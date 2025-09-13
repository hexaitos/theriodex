# Theriodex – Privacy Policy

**Last updated:** 13 September 2025

----------

## Short overview
We store only the minimum needed to run the game and site. Sessions/logs are stored for 24h, DNS logs for 72h (anonymised, last octet removed), and leaderboard scores persist only if you submit them.

**What we store**:

- **Temporary session/game data** while you play (username, guesses, skips, current Pokémon and its ID, guess text, whether or not guess was correct, calculated score). Can be deleted by resetting game.
- **Optional leaderboard entries** (username, score, submission date) – stored only if you choose to submit, requires active consent.
- **Server access logs** (IP, timestamp, requested resource, actions such as which Pokémon was shown).

**Retention**:

- **Session cookies & server access logs:** deleted after a maximum of **24 hours**.
- **Bunny DNS logs:** deleted after **72 hours**; logs are anonymised (last IP octet removed).
- **Leaderboard entries:** kept **perpetually** until you request deletion.

**Where data is processed / stored**:

All processing and storage in done in the EU.

- Website and Redis (leaderboard) provided by: **Scaleway (France)**.
- DNS provided by: **Bunny (Slovenia)**.
- Email provded by: **mailbox.org (Germany)**.
- Operator based in: **Germany**.

**How to delete data**:

- **You can delete the current session data yourself** by navigating to [https://btlr.sh/game/reset](https://btlr.sh/game/reset).
- **Contact us to delete leaderboard data**. 
- Contact: **privacy@btlr.sh** – include details (username, date) to request removal (e.g., leaderboard entry).

----------

## 1. Controller

- **Hexaitos**, henceforth referred to as simply “operator”, based in Germany  
- **Contact:** privacy@btlr.sh

## 2. What we collect

**Only basic server logs are collected automatically.** These may include:

- IP address, timestamp, request method and path, HTTP status, response size, User‑Agent, and referrer.  
- Internal application events needed for operation or debugging (for example: which Pokémon ID was requested, request processing messages, error messages).  
- We do not collect user accounts, profiles, or behavioural tracking data for advertising. No analytics or third‑party trackers are used.

**Server logs (Scaleway / Grafana)**

- **Logs are stored on Scaleway’s Grafana logging/dashboard service and are retained for 1 day.** They include the IP address from which the request was made and information about activity on the website (for example: which Pokémon was displayed). When a user chooses to play the Pokémon Guessing Game, relevant current game data is also logged.

**Session data for the Pokémon Guessing Game**

- A server‑side session mechanism is used (implemented with Rack::Session::Pool). **No cookies are stored on the user’s machine.** The session data is kept on the server (in memory) and is only created once the user explicitly starts playing the game.  
- The following data items are stored in the session while the user is playing:
  - Username
  - Number of guesses
  - Number of correct guesses
  - Number of skipped Pokémon
  - The guess typed in by the user
  - The name and ID of the Pokémon the user was guessing at that time
  - Whether the guess was correct
  - The user’s calculated score
- Rack::Session::Pool keeps session data server‑side (in memory) rather than storing full session payloads in client cookies; session data is lost when the server process restarts.

**Leaderboard (optional, persistent)**

- If the user chooses to store a score in the leaderboard, the following is stored persistently:
  - Calculated score
  - Username
  - Date of submission

## 3. Examples of collected logs

- Example log entries and formats are available in the source code and contain the fields described above.
- Logs stored on Scaleway/Grafana include IPs, timestamps, requested resources (e.g., Pokémon sprite or page), and, when applicable, current game state data recorded at the time the user is playing.

## 4. Why we collect it (purposes) and legal basis

**Purposes:**

- Operation and maintenance of the service (ensure availability, debugging, caching).  
- Security and abuse prevention (detect and respond to attacks or misuse).  
- Performance monitoring and troubleshooting.  
- Enabling the Pokémon Guessing Game and an optional public leaderboard.

**Legal basis:**

- Legitimate interest (Art. 6(1)(f) GDPR) in operating a secure, reliable service. Session data and logs are used only to operate the game and service and to mitigate potential attacks.

## 5. Where data is stored

- **All server processing and storage take place in the European Union.**  
- Hosting and compute:
  - The application runs on **Scaleway Serverless Containers**.  
  - Server logs are stored in **Scaleway’s Grafana/logging service** (retained for 1 day).
- Leaderboard database:
  - The leaderboard is stored in a Redis database running on a small VPS hosted by **Scaleway**.  
  - The Redis instance is reachable only from a private network (VPC) that connects the Serverless Container and the VPS.
- Scaleway is based in France.
- DNS is hosted by **Bunny DNS (Slovenia)**.  
- Emails hosting is provided by **mailbox.org (Germany)**.
- DPAs can be provided upon request.

## 6. Retention

- **Scaleway / Grafana logs:** retained for 1 day. These logs may contain IP addresses and activity data (including Pokémon shown and game state when a user plays).  
- **Session / game data (Rack::Session::Pool):** deleted after 24 hours, when the user uses the “Reset game” button, or when the server restarts (sessions are kept in memory).
- **Leaderboard entries:** stored perpetually (unless a deletion request is processed — see section 9). 
- **DNS queries** : Anonymised DNS queries are stored for 72 hours on Bunny DNS (the last octet of the IP from which the request originated is removed for privacy). 
- In case of an ongoing security investigation or legal obligation, relevant logs or data may be kept for longer as necessary.

## 7. Recipients and disclosures

- Logs, session data and leaderboard data are accessible only to the operator (and any personnel explicitly authorised by the operator).  
- We do not share logs with advertising or analytics companies.  
- We may be required to disclose data to comply with legal obligations or official requests.

## 8. Security

- Reasonable technical and organisational measures are in place to protect data (network isolation for Redis via a VPC, limited access, serverless container security features, restricted retention of logs, etc.). However, no internet service is 100% secure.  
- If you believe you have found a security issue with this application, please contact us promptly with details so it can be handled. The source code of this application is freely available on the operator’s public repositories.

## 9. Your rights

You have the right to:

- Access the personal data we hold about you.  
- Request rectification, erasure, restriction of processing, or object to processing.  
- Request portability of any personal data you have provided.  
- Lodge a complaint with your national supervisory authority.

To exercise these rights, contact the operator at privacy@btlr.sh. For deletion requests related to specific leaderboard entries, provide the username and date of the entry to help locate the record.

## 10. Changes to this policy

This policy may be updated. The “Last updated” date above will indicate the current version.

## Changes from initial privacy policy from 28 August 2025

### Rev. 1 – 13 September 2025
- **Server logs:** now stored on **Scaleway’s Grafana** logging/dashboard service and **retained for 1 day**. Logs include IP addresses, website activity (e.g., which Pokémon was displayed) and **current game data** when a user plays.  
- **Hosting:** clarified that the application runs on **Scaleway Serverless Containers** (no longer hosted on OpenBSD or multiple providers).  
- **DNS:** changed to **Bunny (Slovenia)**.  
- **Session handling:** added a server‑side session mechanism implemented with Rack::Session::Pool; **no cookies are stored on the user’s machine**, session data is created only when the user starts playing and is kept in memory (deleted on server restart).
- **Retention and logging rules:** clarified that session/game data is deleted after 24 hours, on reset, or on server restart; leaderboard entries remain persistent unless a deletion request is made.  
- **Removed** references to prior reverse proxy / OpenBSD log storage and any providers no longer used.

## Reading
- https://www.rubydoc.info/gems/eac-rack/Rack/Session/Pool
- https://www.scaleway.com/en/docs/serverless-containers/faq/
- https://bunny.net/dns
- https://bunny.net/privacy/
- https://www.scaleway.com/en/privacy-policy/