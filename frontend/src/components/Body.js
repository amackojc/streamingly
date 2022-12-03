import React, { useContext, useEffect } from 'react'
import "./Body.css";
import playerContext from '../context/PlayerContext'
import axios from 'axios'
import Songlist from './Songlist'



function Body() {

  const { SetCurrent, currentSong, songs,setArtist, artists, setSongs } = useContext(playerContext)
  

  
  useEffect(() => {
    const fetchData = async () => {
      const result = await axios(
        "http://localhost:3000/api/songs?limit=1000&offset=0?limit=1000&offset=0",
      );
 
      setSongs(result.data);
    
    };
 
    fetchData();
  },[]);
  useEffect(() => {
    const fetchData = async () => {
      const result = await axios(
        "http://localhost:3000/api/albums?limit=1000&offset=0",
      );
      setArtist(result.data);
    };
 
    fetchData();
  },[]);
    return (
        <div className="body">
        <div className="body__info">
         
          <div className="body__infoText">
            <strong>Library</strong>
          </div>
        </div>
 
        <div className="body__songs">
          
    
          { 
          
          songs.map((song, i)=>{
            const artistIneed = artists.find(
              (artist) => artist.id === song.album_id
              ) 

            return (
              
              
                <div className={'songContainer ' + (currentSong === i ? 'selected1' : '')} key={song.id} onClick={() => { SetCurrent(i); }}>
                <Songlist key = {i} title ={song.title}/>              
              </div>
             
            );
          }
          )

          }
          
         
        </div>
        
      </div>
      
    );
  }

export default Body
