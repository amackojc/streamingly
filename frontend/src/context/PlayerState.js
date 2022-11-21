import React, { useReducer } from 'react';
import playerContext from './PlayerContext';
import playerReducer from './Reducer';
import { songsArr, artistsArr, genreArr, albumArr} from './tables';


import {
  SET_CURRENT_SONG,
  TOGGLE_PLAYING,
  SET_SONGS,
} from './Types'

const PlayerState = props => {
  const initialState = {
    currentSong: 0,
    songs: songsArr,
    albums: albumArr,
    artists: artistsArr,
    genres: genreArr,
    playing: false,
    audio: null
  }
  const [state, dispatch] = useReducer(playerReducer, initialState);

  // Set playing state
  const togglePlaying = () => dispatch({ type: TOGGLE_PLAYING, data: state.playing ? false : true })
  const setPlayingFalse = () => dispatch({type:TOGGLE_PLAYING, data: false})
  // Set current song
  const SetCurrent = id => dispatch({ type: SET_CURRENT_SONG, data: id })

  const setSongs = (newSongs) => dispatch({ type: SET_SONGS, data: newSongs })


  return <playerContext.Provider
    value={{
      currentSong: state.currentSong,
      songs: state.songs,
      albums: state.albums,
      artists: state.artists,
      genres: state.genres,
      playing: state.playing,
      audio: state.audio,
      SetCurrent,
      togglePlaying,
      setSongs,
      setPlayingFalse,
    }}>

    {props.children}

  </playerContext.Provider>
}

export default PlayerState;