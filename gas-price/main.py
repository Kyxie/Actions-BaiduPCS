import os
import re
import json
import smtplib
import requests
from dataclasses import dataclass
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from datetime import datetime, timedelta

class Constants:
    TARGET_URL = "https://gaswizard.ca/"
    START_PATTERN = r'class="single-city-prices"'
    DAY_PATTERN = r"Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday"
    DATE_PATTERN = r"(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s\d{1,2},\s\d{4}"
    REGU_PATTERN = r"Regular<\/div><div class=\"fuelprice\">(\d{3}\.\d)\s*\(<span class=\"price-direction (?:pd-nc|pd-up|pd-down)\">(\+?\-?\d*¢|n\/c)<\/span>\)"
    PREM_PATTERN = r"Premium<\/div><div class=\"fuelprice\">(\d{3}\.\d)\s*\(<span class=\"price-direction (?:pd-nc|pd-up|pd-down)\">(\+?\-?\d*¢|n\/c)<\/span>\)"

@dataclass
class User:
    name: str
    city: str
    email: str
    subscribe: bool = True

@dataclass
class GasInfo:
    day: str
    date: str
    regu_price: str
    regu_change: str
    prem_price: str
    prem_change: str

def fetch_gas_data(city: str) -> list[GasInfo]:
    url = f"{Constants.TARGET_URL}{city}"
    try:
        response = requests.get(url, timeout=10)
        response.raise_for_status()
        html_content = response.text
    except Exception as e:
        print(f"Error fetching data for {city}: {e}")
        return []

    match = re.search(Constants.START_PATTERN, html_content)
    if not match:
        return []
    
    start_index = match.start()
    content_snippet = html_content[start_index:start_index+5000]

    days = re.findall(Constants.DAY_PATTERN, content_snippet)
    dates = re.findall(Constants.DATE_PATTERN, content_snippet)
    regus = re.findall(Constants.REGU_PATTERN, content_snippet)
    prems = re.findall(Constants.PREM_PATTERN, content_snippet)

    info_list = []
    for day, date, regu, prem in zip(days, dates, regus, prems):
        info_list.append(GasInfo(
            day=day, date=date,
            regu_price=regu[0], regu_change=regu[1],
            prem_price=prem[0], prem_change=prem[1]
        ))
    
    try:
        info_list.sort(key=lambda x: datetime.strptime(x.date, "%b %d, %Y"))
    except ValueError:
        pass

    return info_list

def generate_report(user: User, info_list: list[GasInfo]) -> str:
    if not info_list:
        return "No gas price data found."

    today = datetime.now()
    today_str = today.strftime("%b %d, %Y").replace(" 0", " ")
    tomorrow_str = (today + timedelta(days=1)).strftime("%b %d, %Y").replace(" 0", " ")
    
    lines = [f"Hi {user.name}, here is the gas report in {user.city}", "-" * 45]
    
    for info in info_list:
        label = ""
        if info.date == today_str: label = " - Today"
        elif info.date == tomorrow_str: label = " - Tomorrow"
        
        lines.append(f"Date: {info.date} ({info.day}){label}")
        lines.append(f"  Regular Price: {info.regu_price}, Change: {info.regu_change}")
        lines.append(f"  Premium Price: {info.prem_price}, Change: {info.prem_change}\n")
    
    lines.append("-" * 45)
    lines.append(f"Source: {Constants.TARGET_URL}{user.city}")
    return "\n".join(lines)

def send_email(user: User, content: str):
    sender_email = os.environ.get("SENDER_EMAIL")
    sender_pass = os.environ.get("SENDER_PASS")
    
    if not sender_email or not sender_pass:
        print("Skipping email: SENDER_EMAIL or SENDER_PASS not set.")
        return

    msg = MIMEMultipart()
    msg["From"] = sender_email
    msg["To"] = user.email
    msg["Subject"] = f"Gas Price Report - {user.city}"
    msg.attach(MIMEText(content, "plain"))

    try:
        with smtplib.SMTP("smtp.gmail.com", 587) as server:
            server.starttls()
            server.login(sender_email, sender_pass)
            server.send_message(msg)
        print(f"✅ Email sent to {user.name} ({user.email})")
    except Exception as e:
        print(f"❌ Failed to send email to {user.name}: {e}")

def main():
    users_json = os.environ.get("USERS", "[]")
    try:
        users_data = json.loads(users_json)
        users = [User(**u) for u in users_data]
    except json.JSONDecodeError:
        print("❌ Error: Invalid USERS json format.")
        return

    if not users:
        print("No users found in configuration.")
        return

    for user in users:
        print(f"Processing for {user.name} in {user.city}...")
        gas_data = fetch_gas_data(user.city)
        report = generate_report(user, gas_data)
        
        print(report)
        
        should_send = os.environ.get("ENABLE_EMAIL", "true").lower() == "true"
        if should_send and user.subscribe:
            send_email(user, report)

if __name__ == "__main__":
    main()