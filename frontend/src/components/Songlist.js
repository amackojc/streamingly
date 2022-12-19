import React from 'react'
import "./Songlist.css"

function Songlist({ title, artist, genre }) {
    return (
        <div className="songRow" >
        <div className="songRow__info">
          <h1>{title}</h1>
          <p>
            {artist} {"  -  "}{genre}
          </p>
        </div>
      </div>
    );
  }
  

export default Songlist
