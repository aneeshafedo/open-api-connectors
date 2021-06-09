import ballerina/test;
import ballerina/http;
import ballerina/log;
 
configurable http:OAuth2RefreshTokenGrantConfig & readonly authConfig = ?;
 
ClientConfig clientConfig = {
   authConfig : authConfig
};
 
Client baseClient = check new Client(clientConfig);

string playlistId = "";

PlayListDetails playlistDetails = {
   description: "My favourite playlist",
   name: "Favourite Playlist"
};

ChangePlayListDetails updatedPlaylist = {
   name: "My favourite playlist 01",
   description: "Best of best"
};

PlayListReorderDetails reorderDetails = {
  range_start: 1,
  insert_before: 2,
  range_length: 1
};

PlaylistTrackInsertionDetails trackDetails = {
   position: 0,
   uris: ["spotify:track:4iV5W9uYEdYUVa79Axb7Rh","spotify:track:1301WleyT98MSxVHPZCA6M"]
};

TrackRemovingDetails removingTracks = {
   tracks: [{ "uri": "spotify:track:4iV5W9uYEdYUVa79Axb7Rh" },{ "uri": "spotify:track:1301WleyT98MSxVHPZCA6M" }]
};

string userID = "rn6zdskc94ss29sryfa49eztb";
 
@test:Config{}
function testGetCurrentPlayList() returns error?{
   CurrentPlaylistDetails result = check baseClient->getMyPlaylists();
   log:printInfo("Number of Playlists : " + (<int>result?.total).toString());
}
@test:Config{}
function testgetPlayslistsByUserID() returns error?{
   UserPlayListDetails result = check baseClient->getPlayslistsByUserID(userID);
   log:printInfo("Number of playlist for the user : " + (<int>result?.total).toString());
}
@test:Config{}
function testcreatePlaylist() returns error?{
   PlaylistObject result = check baseClient->createPlaylist(userID, playlistDetails);
   playlistId = <string>result?.id;
   log:printInfo("Playlist created successfully. Playlist Id : " + playlistId);
}
@test:Config{
   dependsOn: [testcreatePlaylist]
}
function testPlaylistById() returns error?{
   PlaylistObject result = check baseClient->getPlaylistById(playlistId);
   log:printInfo("Palylist Name : " + <string>result?.name);
}
@test:Config{
   dependsOn: [testcreatePlaylist]
}
function testUpdatePlaylist() returns error?{
   _ = check baseClient->updatePlaylist("application/json", playlistId, updatedPlaylist);
   log:printInfo("Successfully updated");
}
@test:Config{
   dependsOn: [testcreatePlaylist]
}
function testGetPlaylistCover() returns error?{
   ImageObjectArr image = check baseClient->getPlaylistCover(playlistId);
   log:printInfo("Image : " + image.toString());
}
@test:Config{
   dependsOn: [testGetPlaylistCover]
}
function testupdatePlaylistCover() returns error?{
   _ = check baseClient->updatePlaylistCover("image/jpeg", playlistId);
   log:printInfo("Cover image updated successfully");
}
@test:Config{
   dependsOn: [testcreatePlaylist]
}
function testaddTracksToPlaylist() returns error?{
   SnapshotIdObject result = check baseClient->addTracksToPlaylist("application/json", playlistId, trackDetails);
   log:printInfo("Successfully added! Snapshot Id : " + <string>result?.snapshot_id);
}
@test:Config{
   dependsOn: [testcreatePlaylist]
}
function testgetPlaylistTracks() returns error?{
   PlaylistTrackDetails result = check baseClient->getPlaylistTracks(playlistId, "LK");
   log:printInfo("Number of tracks received : " + (<int>result?.total).toString());
}

@test:Config{
   dependsOn: [testaddTracksToPlaylist]
}
function testremoveTracksFromPlaylist() returns error?{
   SnapshotIdObject result = check baseClient->removeTracksFromPlaylist("application/json", playlistId, removingTracks);
   log:printInfo("Tracks removed successfully! Snapshot Id : " + <string>result?.snapshot_id);
}

