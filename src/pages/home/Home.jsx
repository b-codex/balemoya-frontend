import React, { useEffect } from "react";
import Sidebar from "../../components/Sidebar/Sidebar";
import Navbar from "../../components/Navbar/Navbar";
import "./Home.scss";
import Widget from "../../components/Widget/Widget.jsx";
import Featured from "../../components/Featured/Featured";
import Chart from "../../components/Chart/Chart";
import { Link } from "react-router-dom";
import { useDispatch, useSelector } from "react-redux";
import { logout, selectUser } from "../../redux/userSlice";
import { useNavigate } from "react-router-dom";

const Home = (props) => {
  const dispatch = useDispatch();
  const user = useSelector(selectUser);
  let navigate = useNavigate();
  useEffect(() => {
    if (user == null) {
      dispatch(logout());
      navigate(`/login`);
    }
  }, []);

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
