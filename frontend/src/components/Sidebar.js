import React, { useContext } from 'react'
import "./Sidebar.css";
import playerContext from '../context/PlayerContext'


function Sidebar() {
  const { SetCurrent, currentSong,songs, setPlayingFalse } = useContext(playerContext)

  

    return (

      <div className="sidebar">
        <div  className="sidebar__title" ><h2>Streamingly</h2></div>
      </div> 
    );
  }
  
  export default Sidebar;
