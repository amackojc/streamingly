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
        "http://localhost:3000/api/songs?limit=4&offset=0?limit=4&offset=0",
      );
 
      setSongs(result.data);
    
    };
 
    fetchData();
  },[]);
  useEffect(() => {
    const fetchData = async () => {
      const result = await axios(
        "http://localhost:3000/api/albums?limit=4&offset=0",
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

              if (typeof song.artists !== 'undefined' && typeof song.genres !== 'undefined' ){ 
                const newArtist = song.artists.toString().replace(/[0-9]/g, '').replace(',',' ');
                const newGenre = song.genres.toString().replace(/[0-9]/g, '').replace(',',' ').replace(',,',' ').replace(',,',' ');
              if (typeof artistIneed !== 'undefined'){
            return (
              
              
                <div className={'songContainer ' + (currentSong === i ? 'selected1' : '')} key={song.id} onClick={() => { SetCurrent(i); }}>
                <Songlist key = {i} title ={song.title} artist = {newArtist} genre = {newGenre}/>                
              </div>
             
            );
          }
              }})


          }
          
         
        </div>
        
      </div>
      
    );
  }

export default Body
