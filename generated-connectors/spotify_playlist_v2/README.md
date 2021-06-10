# Ballerina Spotify Playlist Connector

Conncets to Spotify Playlist API

## Compatibility
|                       |    Version                  |
|:---------------------:|:---------------------------:|
| Ballerina Language    | swan-lake-Alpha5            |
| Spotify Playlist API  | v1                          |


# Quickstart

## Obtain Tokens for Authentication

Spotify Web API follows OAuth 2.0 mechanism for authentication. Please follow below steps get tokens to access the API

1. Create a Spotify account
2. Register your application inSpotify developer portal
2. Use Client Id and Client Secret to get access token or refresh token.

Please see [here](https://developer.spotify.com/documentation/web-api/quick-start/) for more details. 

Then provide the tokens to configure the client. 

### Client configuration

```ballerina
    import ballerinax/spotify;

    spotify:ClientConfig clientConfig = {
        authConfig : {
            refreshUrl = "<Refresh URL>"
            refreshToken = "<Refresh Token>"
            clientId = "<Client Id>"
            clientSecret = "<Client Secret>"
        }
    };

    spotify:Client spotifyClient = new spotify:Client(clientConfig);
```


## Module Overview

The Spotify Playlist connector consume the data exposed in [https://api.spotify.com](https://api.spotify.com/v1). It is currently supporting the following operations.

- getMyPlaylists
- getPlaylistById
- updatePlaylist
- getPlaylistCover
- updatePlaylistCover
- getPlaylistTracks
- reorderOrReplacePlaylistTracks
- getPlayslistsByUserID
- createPlaylist


    