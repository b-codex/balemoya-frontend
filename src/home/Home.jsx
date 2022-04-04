import React from "react";
import Sidebar from "../components/Sidebar/Sidebar";
import Navbar from "../components/Navbar/Navbar";
import "./Home.scss";
import Widget from "../components/Widget/Widget.jsx";
import Featured from "../components/Featured/Featured";
import Chart from "../components/Chart/Chart";


const Home = (props) => {
  return (
    <div className="home">
      <Sidebar />
      <div className="home_container">
        <Navbar />
        <div className="widgets">
          <Widget type="user" />
          <Widget type="order" />
          <Widget type="earning" />
          <Widget type="balance" />
        </div>
        <div className="charts">
          <Featured/>
          <Chart/>

        </div>
      </div>
    </div>
  );
};

export default Home;
