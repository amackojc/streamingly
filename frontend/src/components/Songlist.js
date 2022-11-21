import React from 'react'
import "./Songlist.css"

function Songlist({ title }) {
    return (
        <div className="songRow" >
        <div className="songRow__info">
          <h1>{title}</h1>
        </div>
      </div>
    );
  }
  

export default Songlist
