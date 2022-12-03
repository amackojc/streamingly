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

  // Prev song
  const prevSong = () => {
    if (state.currentSong === 0) {
      SetCurrent(state.songs.length - 1)
    } else {
      SetCurrent(state.currentSong - 1)
    }
  }
  
  // Next song
  const nextSong = () => {
    
    if (state.currentSong === state.songs.length - 1) {
      SetCurrent(0)
    } else {
      SetCurrent(state.currentSong + 1)
    }
  }



  // End of Song
  const handleEnd = () => {
    // Check for random and repeat options
    if (state.random) {
      return dispatch({ type: SET_CURRENT_SONG, data: ~~(Math.random() * state.songs.length) })
    } else {
      if (state.repeat) {
        nextSong()
      } else if ((state.currentSong === state.songs.length - 1)) {
        return
      } else {
        nextSong();
      }
    }
  }


  return <playerContext.Provider
    value={{
      currentSong: state.currentSong,
      songs: state.songs,
      albums: state.albums,
      artists: state.artists,
      genres: state.genres,
      playing: state.playing,
      audio: state.audio,
      nextSong,
      prevSong,
      SetCurrent,
      togglePlaying,
      handleEnd,
      setSongs,
      setPlayingFalse,
    }}>

    {props.children}

  </playerContext.Provider>
}

export default PlayerState;