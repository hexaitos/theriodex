# Theriodex – Privacy Policy

**Last updated:** 27 February 2026

---

## Short overview

We store only the minimum needed to run the game and site. Sessions/logs are stored for 24h and leaderboard scores persist only if you submit them. A privacy-friendly analytics service has been added in October 2025 to give us a general idea of how our service is used. This data is anonymised and never sold to anyone.

**What we store**:

- Temporary session/game data:
  - For the Pokémon Guessing Game (username, guesses, skips, current Pokémon and its ID, guess text, whether or not guess was correct, calculated score).
  - User preferences such as theme, font and cursor
- Optional leaderboard entries (username, score, submission date) – stored only if you choose to submit, requires active consent.
- Server access logs (IP, timestamp, requested resource, actions such as which Pokémon was shown).
- Basic analytics data via self-hosted Plausible (page views, referral sources, browser/OS information - no personal data collected).
  - You can view the exact same data that we have access to on [https://plausible.theriodex.net/theriodex.net/](https://plausible.theriodex.net/theriodex.net/).

**Retention**:

- Session cookies & server access logs: deleted after a maximum of 24 hours.
- Analytics data: kept perpetually.
- Leaderboard entries: kept perpetually until you request deletion.

**Where data is processed / stored**:

All processing and storage is done in the EU.

- Website, Redis (leaderboard), and analytics hosted by: netcup (Germany).
- DNS provided by: deSEC (Germany).
- Email provided by: mailbox.org (Germany).
- Operator based in: Germany.

**How to delete data**:

- You can delete the current session data yourself by navigating to [https://theriodex.net/game/reset](https://theriodex.net/game/reset) (Warning: Clicking this link will immediately delete your current game data as well as your selected customisation options).
- Contact us to delete leaderboard data.
- Contact: privacy@theriodex.net – include details (username, date) to request removal (e.g., leaderboard entry).

---

## 1. Controller

- Hexaitos, henceforth referred to as simply "operator", based in Germany
- Contact: privacy@theriodex.net

## 2. What we collect

Only basic server logs and minimal analytics are collected automatically. These may include:

- IP address, timestamp, request method and path, HTTP status, response size, User‑Agent, and referrer.
- Internal application events needed for operation or debugging (for example: which Pokémon ID was requested, request processing messages, error messages).
- Basic analytics data collected by self-hosted Plausible: page views, referral sources, browser and operating system information (without collecting personal data).
- We do not collect user accounts, profiles, or behavioural tracking data for advertising. No third‑party trackers are used beyond our self-hosted Plausible instance.

**Server logs (netcup)**

- Logs are stored on our netcup VPS and are retained for 1 day. They include the IP address from which the request was made and information about activity on the website (for example: which Pokémon was displayed). When a user chooses to play the Pokémon Guessing Game, relevant current game data is also logged.

**Analytics (self-hosted Plausible)**

- Plausible Analytics is self-hosted on our own server and collects only basic, non-personal usage data.
- No cookies are used for tracking; Plausible is GDPR-compliant out of the box.
- Data collected includes page views, referral sources, browser type, operating system, and country (determined from IP without storing the full IP).
- Since Plausible is self-hosted, all analytics data remains on our netcup VPS in Germany.
- For more information about how Plausible works without compromising user privacy, please view their [data policy](https://plausible.io/data-policy).

**Leaderboard (optional, persistent)**

- If the user chooses to store a score in the leaderboard, the following is stored persistently:
  - Calculated score
  - Username
  - Date of submission

### 2.1 Session data

The most amount of information is stored in a session cookie. A server‑side session mechanism is used (implemented with Rack::Session::Pool) which stores a single transient cookie containing only a session identifier on your machine, the actual cookie _data_ is stored on the server. Therefore, Rack::Session::Pool keeps session data server‑side (in memory) rather than storing full session payloads in client cookies; session data is lost when the server process restarts.

**Session data for the Pokémon Guessing Game**

- The following data items are stored in the session while the user is playing:
  - Username
  - Number of guesses
  - Number of correct guesses
  - Number of skipped Pokémon
  - The guess typed in by the user
  - The name and ID of the Pokémon the user was guessing at that time
  - Whether the guess was correct
  - The user's calculated score

**Session data for user preferences**
Additionally, we store user preferences in Rack::Session::Pool as well. These include (but may not necessarily be limited to) things such as the theme, cursor or font a user has selected as well as information about whether a specific theme has been unlocked.

**Serial for unlocking themes**
When the user plays the Pokémon Guessing Game and manages to reach a certain number of points, they may unlock additional themes. To unlock these themes later on, a serial is generated with which the user may unlock the theme again at a later point in time. These serials are _not_ stored and contain – in a slightly obfuscated manner – the number of points achieved. No personally-identifiable information is stored within these serials, simply the number of points acquired.

**List of all session cookies**
The following is an overview of all the cookies / data stored per session. You may verify where and how this data is used by looking for `session[:key_name_here]` in the software's source code. Replace `key_name_here` with the session key found in the first column of the following table:

| Session Key            | Description / Stored Data                             |
| ---------------------- | ----------------------------------------------------- |
| `cursor`               | Stores the name of the currently selected cursor      |
| `database_username`    | The username formatted for database storage           |
| `difficulty`           | Selected difficulty level                             |
| `font`                 | Stores the name of the currently selected font        |
| `gen`                  | Stores the generation for the Pokémon Guessing Game   |
| `guesses`              | Number of guesses in the game                         |
| `points`               | Calcuated game score                                  |
| `pokemon_info`         | Pokémon game information                              |
| `results`              | Game results (how many guesses, points etc.)          |
| `saved_in_leaderboard` | Flag indicating if score was submitted to leaderboard |
| `serial`               | Serial number for unlocking themes                    |
| `skips`                | Number of skips used                                  |
| `theme`                | Stores the name of the currently selected theme       |
| `unlocked_themes`      | List of themes unlocked by the user                   |
| `username`             | Username selected when starting Pokémon Guessing Game |

## 3. Examples of collected logs

- Example log entries and formats are available in the source code and contain the fields described above.
- Logs stored on netcup include IPs, timestamps, requested resources (e.g., Pokémon sprite or page), and, when applicable, current game state data recorded at the time the user is playing.
- Plausible analytics data is publicly viewable at [https://plausible.theriodex.net/theriodex.net/](https://plausible.theriodex.net/theriodex.net/).

## 4. Why we collect it (purposes) and legal basis

**Purposes:**

- Operation and maintenance of the service (ensure availability, debugging, caching).
- Security and abuse prevention (detect and respond to attacks or misuse).
- Performance monitoring and troubleshooting.
- Enabling the Pokémon Guessing Game and an optional public leaderboard.
- Enabling user customisation and accessibility
- Basic usage statistics to understand how the site is being used (via self-hosted Plausible).

**Legal basis:**

- Legitimate interest (Art. 6(1)(f) GDPR) in operating a secure, reliable service. Session data and logs are used only to operate the game and service and to mitigate potential attacks.
- Self-hosted Plausible analytics is GDPR-compliant by design, collecting only non-personal data without requiring user consent.

## 5. Where data is stored

- All server processing and storage take place in the European Union.
- Hosting and compute:
  - The application runs on a netcup VPS located in Nuremberg, Germany.
  - Server logs are stored on the same VPS (retained for 1 day).
- Leaderboard database:
  - The leaderboard is stored in a Redis database running on the same netcup VPS.
- Analytics:
  - Plausible Analytics is self-hosted on the same netcup VPS in Nuremberg, Germany.
- DNS is hosted by deSEC (Germany).
- Emails hosting is provided by mailbox.org (Germany).
- netcup ensures all hosting services are fully compliant with the EU's General Data Protection Regulation (GDPR).
- DPAs can be provided upon request.

## 6. Retention

- Server logs: retained for 1 day. These logs may contain IP addresses and activity data (including Pokémon shown and game state when a user plays).
- Session / game data (Rack::Session::Pool): deleted after 24 hours, when the user uses the "Reset game" button, or when the server restarts (sessions are kept in memory).
- Leaderboard entries: stored perpetually (unless a deletion request is processed — see section 9).
- Analytics data: Analytics data is not deleted (as this would make using analytics rather pointless in the first place). However, Plausible analytics data does not contain any personal identifiable information.
- In case of an ongoing security investigation or legal obligation, relevant logs or data may be kept for longer as necessary.

## 7. Recipients and disclosures

- Logs, session data, leaderboard data, and analytics data are accessible only to the operator (and any personnel explicitly authorised by the operator).
- Since Plausible is self-hosted, no third party (including Plausible) has access to the analytics data.
- We do not share logs with advertising or analytics companies.
- We may be required to disclose data to comply with legal obligations or official requests.

## 8. Security

- Reasonable technical and organisational measures are in place to protect data (restricted access, server security features, limited retention of logs, etc.). However, no internet service is 100% secure.
- If you believe you have found a security issue with this application, please contact us promptly with details so it can be handled. The source code of this application is freely available on the operator's public repositories.

## 9. Your rights

You have the right to:

- Access the personal data we hold about you.
- Request rectification, erasure, restriction of processing, or object to processing.
- Request portability of any personal data you have provided.
- Lodge a complaint with your national supervisory authority.

To exercise these rights, contact the operator at privacy@theriodex.net. For deletion requests related to specific leaderboard entries, provide the username and date of the entry to help locate the record.

## 10. Changes to this policy

This policy may be updated. The "Last updated" date above will indicate the current version.

## Full changelog

### Initial version – 28 August 2025

- First published privacy policy establishing data collection practices for the Theriodex service.

### Rev. 1 – 13 September 2025

- Server logs: now stored on Scaleway's Grafana logging/dashboard service and retained for 1 day. Logs include IP addresses, website activity (e.g., which Pokémon was displayed) and current game data when a user plays.
- Hosting: clarified that the application runs on Scaleway Serverless Containers (no longer hosted on OpenBSD or multiple providers).
- DNS: changed to Bunny (Slovenia).
- Session handling: added a server‑side session mechanism implemented with Rack::Session::Pool; no cookies are stored on the user's machine, session data is created only when the user starts playing and is kept in memory (deleted on server restart).
- Retention and logging rules: clarified that session/game data is deleted after 24 hours, on reset, or on server restart; leaderboard entries remain persistent unless a deletion request is made.
- Removed references to prior reverse proxy / OpenBSD log storage and any providers no longer used.

### Rev. 2 – 31 October 2025

- Added self-hosted Plausible Analytics for basic, GDPR-compliant usage statistics.
- Hosting: moved from Scaleway to netcup VPS (Germany), with servers located in Nuremberg.
- DNS: changed from Bunny (Slovenia) to deSEC (Germany).
- Clarified that Plausible is self-hosted on our netcup VPS in Germany (not hosted by Plausible in Netherlands).
- Analytics data retention: self-hosted Plausible analytics data is retained for 30 days.
- Updated "Where data is stored" section to reflect new providers and their GDPR compliance commitments.
- Updated retention periods to include analytics data.
- Added public analytics URL where anyone can view the available analytics data.

### Rev. 3 – 27 February 2026

- **Session architecture clarification**: Corrected technical description of Rack::Session::Pool implementation to clarify that while session _data_ is stored server-side in memory, a single transient cookie containing only the session identifier _is_ stored on the user's machine (previously stated "No cookies are stored"). The actual session data remains server-side and is lost on server restart.
- **Session data transparency**: Added comprehensive breakdown of all server-side session data in new Section 2.1, including detailed table of all 14 session keys (`cursor`, `font`, `theme`, `unlocked_themes`, `serial`, etc.) and their specific purposes.
- **User preferences**: Clarified that session storage includes user customisation data (selected theme, cursor style, font choice, difficulty settings) alongside game data.
- **Theme unlock mechanism**: Documented serial generation system for unlocking themes via gameplay achievements; confirmed serials contain only obfuscated point counts with no personal data.
- **Reset functionality**: Updated description of reset link to clarify it deletes both current game data _and_ selected customisation options/preferences.
- **Purposes**: Added "Enabling user customisation and accessibility" to the list of data processing purposes in Section 4.
- **Short overview**: Expanded bullet points to explicitly mention user preferences (theme, font, cursor) as stored data categories.
