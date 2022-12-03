import {
    SET_CURRENT_SONG,
    TOGGLE_PLAYING,
    SET_SONGS

  } from './Types'
  
export default (state, action) => {
    switch (action.type) {
      case SET_CURRENT_SONG:
        return {
          ...state,
          currentSong: action.data,
          playing: true
        }
      case TOGGLE_PLAYING:
        return {
          ...state,
          playing: action.data
        }
      case SET_SONGS: 
        return {
          ...state,
          songs: action.data,
          
        }
      default:
        return state
    }
  
  }
  