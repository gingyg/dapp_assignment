pragma solidity ^0.4.0;

contract GPSnake {
  // Parameters of the contract. Reflects the current state
  // of the 'king of the hill' game. Users can leave a note
  // for the next person to see.

  address public owner;
  uint public lastClaimed;
  int public lat;
  int public lon;
  string public note;

  event logClaim(address owner, uint time, int lat, int lon,
    string note);

  // Nat Spec comment:

  /// Be the King of the Hill! Bare bones implementation
  /// at the moment. _lat and _lon can be pulled from HTML5
  /// Geolocation API.
  function GPSnake(
      address _owner,
      int _lat,
      int _lon,
      string _note
  ) {
    owner = _owner;
    lastClaimed = block.timestamp;
    lat = _lat;
    lon = _lon;
    note = _note;
  }

  /// Players can claim any territory. The contract will
  /// check the GPS coordinates input against the instantiated
  /// coordinates to ensure arrival at the location. In the future,
  /// further verification methods will need to be implemented (perhaps
  /// leveraging photos, reputation, or staking/challenging claims)

  function getInfo() public constant returns(address, uint, int, int, string) {
       return (owner, lastClaimed, lat, lon, note);
  }

  function claim(int _lat, int _lon, string _note) {
    // Check GPS equality
    if ((lat != _lat) && (lon != _lon)){
      throw;
    }

    // Set new variables
    owner = msg.sender;
    lastClaimed = block.timestamp;
    lat = _lat;
    lon = _lon;
    note = _note;

    //logClaim(msg.sender, block.timestamp, _lat, _lon, _note);
  }
}

contract LocationManager{


    mapping(uint => address) public locations;

    function gpsToIndex(int _lat, int _lon) public constant returns (uint){
        // Product of UINT casted latitude and longitude is used as index
        // for the mapping
        return (uint256(_lat) * uint256(_lon));
    }

    function initLocation(int _lat, int _lon) returns (address){
        // When no contract exists for a given location, create a new contract

        address newLocation = new GPSnake(0x0, _lat, _lon, "This location has not been claimed yet!");
        locations[gpsToIndex(_lat, _lon)] = newLocation;
        return(newLocation);
    }

    function contains(uint _locationIndex) public constant returns (bool) {
      // Check to see if a location contract exists at the given index
      return(locations[_locationIndex] != address(0x0));
    }

    function checkLocation(int _lat, int _lon) public returns (address) {
      // returns existing contract or makes one and places into locations array
      uint locationIndex = gpsToIndex(_lat, _lon);

      if(contains(locationIndex)){
        return(locations[locationIndex]);
      }else{
        return(initLocation(_lat, _lon));
      }

    }

}
