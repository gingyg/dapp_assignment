# GPSnake
### (A bit Snake... plus GPS... plus lots of players...)
#### (ok maybe not really like Snake...)

Very early and not fully functional distributed geo-tagging/geo-caching game. Kind of like
King of the Hill or Capture the Flag, but with everybody running around capturing
zones based on GPS coordinates and leaving notes for each other.

**Rules/Instructions:**
1) Play by accessing index.html from their phones or laptops - any browser
that can acquire their GPS coordinates
2) Players can claim the GPS coordinates they are located at. They can also leave
notes for other players when at a location. The last posted note stays visible.

**How to get it working**
Works on ganache-cli. Remix needs to be used to launch the contracts before loading index.html
1) Use remix to deploy a test GPSnake contract.
2) Use remix to deploy a test LocationManager contract (this is only half functional).
3) Load index.html
4) Type some text and hit **Claim!**,  then refresh to see the new results pulled from ledger.

**Current State**
- A GPSnake contract is deployed for each location. GPSnake contract works as expected. This contract
- The LocationManager contract is supposed to manage and index all of the existing
GPSnake contracts so that only one can exist per GPS location.
  - Currently not working because LocationManager functions change the contract statement
  - Instead, Events need to be integrated since the contract minting functions can't return values
  - The LocationManager contract stores the GPSnake contract addresses in a mapping
  - The checkLocation function should check for a contract first and init a new one if the mapping list a proper GPSnake contract at the index.
- UX Design is almost non-existant. Mostly just overall game logic and ideas on how it could grow
  - Lots of work on async callback/promise code needs to be done on the web UI

**Ideas for future development:**
- Staking and payout mechanism that would incentivize "landgrabs" and competition
  - Current state is more of a 'leave hidden notes for people' game
- GPS verification mechanisms
  - Prevent fake GPS uploads, ensure people are actually on site
- Metamask/outside wallet integration
