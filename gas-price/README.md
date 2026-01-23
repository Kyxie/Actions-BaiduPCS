# Gas Price Tomorrow in Canada

This is a bot for checking tomorrow's gas price in Canada

## How to run

### Locally

- If you want to run locally, make sure install Python 3.10 and the libraries

  ```bash
  pip install requests
  ```

- Modify `config.py`
  - SMTP
    - This bot supports Gmail or Outlook for SMTP Server, you should get a username (normally your email) and password
    - Gmail: https://support.google.com/a/answer/176600?hl=en
    - Outlook: https://support.microsoft.com/en-us/office/pop-imap-and-smtp-settings-for-outlook-com-d088b986-291d-42b8-9564-9c414e2aa040

  - Recipient
    - The `users` key are for the recipients, fill the recipients' information, and you can add multiple recipients
    - Support city list: https://gaswizard.ca/gas-price-predictions/

- Run

  ```bash
  python main.py
  ```

### GitHub Actions

- I recommend using GitHub Actions, check `.github/workflows/gas-price.yml`, I set to trigger the workflow everyday 5pm (Toronto Summer time)
- I also recommend using a private repository, to avoid make sensitive information public
