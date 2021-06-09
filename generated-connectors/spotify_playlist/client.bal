import  ballerina/http;
import  ballerina/url;
import  ballerina/lang.'string;

public type ClientConfig record {
    http:BearerTokenConfig|http:OAuth2RefreshTokenGrantConfig authConfig;
    http:ClientSecureSocket secureSocketConfig?;
};

type ImageObjectArr ImageObject[];

public client class Client {
    http:Client clientEp;
    public isolated function init(ClientConfig clientConfig, string serviceUrl = "https://api.spotify.com/v1") returns error? {
        http:ClientSecureSocket? secureSocketConfig = clientConfig?.secureSocketConfig;
        http:Client httpEp = check new (serviceUrl, { auth: clientConfig.authConfig, secureSocket: secureSocketConfig });
        self.clientEp = httpEp;
    }
    remote isolated function getMyPlaylists(int? 'limit = (), int? offset = ()) returns CurrentPlaylistDetails|error {
        string  path = string `/me/playlists`;
        map<anydata> queryParam = {'limit: 'limit, offset: offset};
        path = path + getPathForQueryParam(queryParam);
        CurrentPlaylistDetails response = check self.clientEp-> get(path, targetType = CurrentPlaylistDetails);
        return response;
    }
    remote isolated function getPlaylistById(string playlist_id, string? market = (), string? fields = (), string? additional_types = ()) returns PlaylistObject|error {
        string  path = string `/playlists/${playlist_id}`;
        map<anydata> queryParam = {market: market, fields: fields, additional_types: additional_types};
        path = path + getPathForQueryParam(queryParam);
        PlaylistObject response = check self.clientEp-> get(path, targetType = PlaylistObject);
        return response;
    }
    remote isolated function updatePlaylist(string 'Content\-Type, string playlist_id, ChangePlayListDetails payload) returns error? {
        string  path = string `/playlists/${playlist_id}`;
        map<string|string[]> accHeaders = {'Content\-Type: 'Content\-Type};
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
         _ = check self.clientEp->put(path, request, headers = accHeaders, targetType=http:Response);
    }
    remote isolated function getPlaylistCover(string playlist_id) returns ImageObjectArr|error {
        string  path = string `/playlists/${playlist_id}/images`;
        ImageObjectArr response = check self.clientEp-> get(path, targetType = ImageObjectArr);
        return response;
    }
    // no use of this method
    remote isolated function updatePlaylistCover(string 'Content\-Type, string playlist_id) returns error? {
        string  path = string `/playlists/${playlist_id}/images`;
        map<string|string[]> accHeaders = {'Content\-Type: 'Content\-Type};
        http:Request request = new;
        //TODO: Update the request as needed;
         _ = check self.clientEp-> put(path, request, headers = accHeaders, targetType=http:Response);
    }
    remote isolated function getPlaylistTracks(string playlist_id, string market, string? fields = (), int? 'limit = (), int? offset = (), string? additional_types = ()) returns PlaylistTrackDetails|error {
        string  path = string `/playlists/${playlist_id}/tracks`;
        map<anydata> queryParam = {market: market, fields: fields, 'limit: 'limit, offset: offset, additional_types: additional_types};
        path = path + getPathForQueryParam(queryParam);
        PlaylistTrackDetails response = check self.clientEp-> get(path, targetType = PlaylistTrackDetails);
        return response;
    }
    remote isolated function reorderOrReplacePlaylistTracks(string playlist_id, PlayListReorderDetails payload, string? uris = ()) returns SnapshotIdObject|error {
        string  path = string `/playlists/${playlist_id}/tracks`;
        map<anydata> queryParam = {uris: uris};
        path = path + getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        SnapshotIdObject response = check self.clientEp->put(path, request, targetType=SnapshotIdObject);
        return response;
    }
    remote isolated function addTracksToPlaylist(string 'Content\-Type, string playlist_id, PlaylistTrackInsertionDetails payload, int? position = (), string? uris = ()) returns SnapshotIdObject|error {
        string  path = string `/playlists/${playlist_id}/tracks`;
        map<anydata> queryParam = {position: position, uris: uris};
        path = path + getPathForQueryParam(queryParam);
        map<string|string[]> accHeaders = {'Content\-Type: 'Content\-Type};
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        SnapshotIdObject response = check self.clientEp->post(path, request, headers = accHeaders, targetType=SnapshotIdObject);
        // not generated
        return response;
    }
    remote isolated function removeTracksFromPlaylist(string 'Content\-Type, string playlist_id, TrackRemovingDetails payload) returns SnapshotIdObject|error {
        string  path = string `/playlists/${playlist_id}/tracks`;
        map<string|string[]> accHeaders = {'Content\-Type: 'Content\-Type};
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        SnapshotIdObject response = check self.clientEp->delete(path, request, headers = accHeaders, targetType=SnapshotIdObject);
        return response;
    }
    remote isolated function getPlayslistsByUserID(string user_id, int? 'limit = (), int? offset = ()) returns UserPlayListDetails|error {
        string  path = string `/users/${user_id}/playlists`;
        map<anydata> queryParam = {'limit: 'limit, offset: offset};
        path = path + getPathForQueryParam(queryParam);
        UserPlayListDetails response = check self.clientEp-> get(path, targetType = UserPlayListDetails);
        return response;
    }
    remote isolated function createPlaylist(string user_id, PlayListDetails payload) returns PlaylistObject|error {
        string  path = string `/users/${user_id}/playlists`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        PlaylistObject response = check self.clientEp->post(path, request, targetType=PlaylistObject);
        return response;
    }
}

isolated function  getPathForQueryParam(map<anydata>   queryParam)  returns  string {
    string[] param = [];
    param[param.length()] = "?";
    foreach  var [key, value] in  queryParam.entries() {
        if  value  is  () {
            _ = queryParam.remove(key);
        } else {
            if  string:startsWith( key, "'") {
                 param[param.length()] = string:substring(key, 1, key.length());
            } else {
                param[param.length()] = key;
            }
            param[param.length()] = "=";
            if  value  is  string {
                string updateV =  checkpanic url:encode(value, "UTF-8");
                param[param.length()] = updateV;
            } else {
                param[param.length()] = value.toString();
            }
            param[param.length()] = "&";
        }
    }
    _ = param.remove(param.length()-1);
    if  param.length() ==  1 {
        _ = param.remove(0);
    }
    string restOfPath = string:'join("", ...param);
    return restOfPath;
}
