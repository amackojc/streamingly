import React,   { useState, useEffect, useRef, useContext } from "react";
import PlayCircleOutlineIcon from "@material-ui/icons/PlayCircleOutline";
import SkipPreviousIcon from "@material-ui/icons/SkipPrevious";
import SkipNextIcon from "@material-ui/icons/SkipNext";
import PauseCircleOutlineIcon from "@material-ui/icons/PauseCircleOutline";
import "./Player.css";
import PlayerContext from '../context/PlayerContext'
import axios from 'axios'

function Player(props) {
  const {
    currentSong,
    songs,
    nextSong,
    prevSong,
    playing,
    togglePlaying,
    handleEnd,
    setAlbum
    

  } = useContext(PlayerContext)

  const audio = useRef('audio_tag');

  // self State
  const [statevolum] = useState(0.3)
  const [dur, setDur] = useState(0)

  const toggleAudio = () => audio.current.paused ? audio.current.play() : audio.current.pause();


  useEffect(() => {
    const fetchData = async () => {
      const result = await axios(
        "http://localhost:3000/api/albums?limit=1000&offset=0",
      );
 
      setAlbum(result.data);
      
    };
 
    fetchData();
  },[]);


  useEffect(() => {
    audio.current.volume = statevolum;
    if (playing) { toggleAudio() }
  }, [currentSong])


  // eslint-disable-next-line no-lone-blocks
  {
    if (typeof songs[currentSong].artists !== 'undefined') {

   

    return (

  

    <div className="footer">
       
    <audio 
    onCanPlay={(e) => setDur(e.target.duration)}
    onEnded={handleEnd}
    ref={audio}
    type="audio/mpeg"
    preload='true'
    src={"http://localhost:3000/media/"+songs[currentSong].media}
    />
       

      <div className="footer__center">
        <SkipPreviousIcon onClick={prevSong} className="footer__icon" />      
        {playing ? (
          <PauseCircleOutlineIcon
          onClick={() => { togglePlaying(); toggleAudio(); }}
            fontSize="large"
            className="footer__icon__play"
          />
        ) : (
          <PlayCircleOutlineIcon
          onClick={() => { togglePlaying(); toggleAudio(); }}
            fontSize="large"
            className="footer__icon__play"
          />
        )}
 
        <SkipNextIcon  onClick={nextSong} className="footer__icon" />
        
      </div>
    </div>
    )
}
} 
}
export default Player
