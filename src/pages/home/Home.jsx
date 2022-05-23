import React from "react";
import Sidebar from "../../components/Sidebar/Sidebar";
import Navbar from "../../components/Navbar/Navbar";
import "./Home.scss";
import Widget from "../../components/Widget/Widget.jsx";
import Featured from "../../components/Featured/Featured";
import Chart from "../../components/Chart/Chart";
import { Link } from "react-router-dom";

const Home = (props) => {
  return (
    <div className="home">
      <Sidebar />
      <div className="home_container">
        <Navbar />
        <div className="widgets">
          <Link
            className="links"
            to="/users"
            style={{ textDecoration: "none", color: "inherit" }}
          >
            <Widget type="user" />
          </Link>

          <Link
            className="links"
            to="/users"
            style={{ textDecoration: "none", color: "inherit" }}
          >
            <Widget type="reports" />
          </Link>
          <Link
            className="links"
            to="/users"
            style={{ textDecoration: "none", color: "inherit" }}
          >
            <Widget type="revenue" />
          </Link>
        </div>
        <div className="charts">
          <Featured />
          <Chart />
        </div>
      </div>
    </div>
  );
};

export default Home;
