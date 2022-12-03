import React, { useContext } from 'react'
import "./Sidebar.css";
import SidebarOption from "./SidebarOption";
import HomeIcon from "@material-ui/icons/Home";
import {Link} from "react-router-dom";
import playerContext from '../context/PlayerContext'


function Sidebar() {
  const { SetCurrent, currentSong,songs, setPlayingFalse } = useContext(playerContext)

  

    return (

        <div className="sidebar">
        <div  className="sidebar__title" ><h2>Streamingly</h2></div>
        <br/>
        <Link onClick={() => { SetCurrent(0); setPlayingFalse()}} style={{ textDecoration: 'none' }} to="/"><SidebarOption Icon={HomeIcon} title="Library" /></Link>
        <br/>
        <strong className="music">Music</strong>
        <hr/>

      </div> 
    );
  }
  
  export default Sidebar;
