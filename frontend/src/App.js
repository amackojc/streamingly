import React from 'react';
import './App.css';
import Player from "./components/Player"
import Body from "./components/Body"
import PlayerState from "./context/PlayerState"
import {
  BrowserRouter as Router,
  Route
} from "react-router-dom"
import Sidebar from './components/Sidebar';


function App() {  
  return (
 <PlayerState>
    <Router>
         
      <div className="App">
     {/*<Login/> */}
     <div className="player">
      <div className="player__body">
    <Sidebar/>
     <Player/>
    <Route exact path = "/" render = {props =>(
         <Body/>
    )}/>
    </div>
    </div>
    </div>
    
    </Router>
    </PlayerState>
  );
}

export default App;
