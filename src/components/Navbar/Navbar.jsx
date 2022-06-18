import React, { useContext, useEffect, useState } from "react";
import "./Navbar.scss";
import SearchOutlinedIcon from "@mui/icons-material/SearchOutlined";
import LanguageOutlinedIcon from "@mui/icons-material/LanguageOutlined";
import DarkModeOutlinedIcon from "@mui/icons-material/DarkModeOutlined";
import FullscreenExitOutlinedIcon from "@mui/icons-material/FullscreenExitOutlined";
import NotificationsNoneOutlinedIcon from "@mui/icons-material/NotificationsNoneOutlined";
import ChatBubbleOutlineOutlinedIcon from "@mui/icons-material/ChatBubbleOutlineOutlined";
import ListOutlinedIcon from "@mui/icons-material/ListOutlined";
import ReportGmailerrorredIcon from "@mui/icons-material/ReportGmailerrorred";
import { DarkModeContext } from "../../context/darkModeContext";
import { Avatar } from "@mui/material";
import { Link } from "react-router-dom";
import { getInitials } from "../../utils/get-initials";
import { getAdminProfile } from "../../utils/customer";
import { useSelector } from "react-redux";
import { selectUser } from "../../redux/userSlice";

const Navbar = () => {
  const { dispatch } = useContext(DarkModeContext);
  const user = useSelector(selectUser);
  const [userData, setUserData] = useState(null);
  const [err, setErr] = useState("");
  useEffect(() => {
    getAdminProfile(user.token)
      .then((res) => res.json())
      .then((data) => {
        setUserData(data);
      })
      .catch((err) => {
        setErr("Something went wrong");
      });
  }, []);

  return (
    <div className="navbar">
      <div className="wrapper">
        <div className="search" style={{ visibility: "hidden" }}></div>
        <div className="items">
          <div className="item">
            <DarkModeOutlinedIcon
              className="icon"
              onClick={() => dispatch({ type: "TOGGLE" })}
            />
          </div>
          <div className="item">
            <FullscreenExitOutlinedIcon
              style={{ cursor: "Pointer" }}
              className="icon"
            />
          </div>
          <Link
            to="/reports"
            style={{ textDecoration: "none", color: "inherit" }}
          >
            <div className="item">
              <ReportGmailerrorredIcon className="icon" />

              <div className="counter">1</div>
            </div>
          </Link>
          <div className="item">
            {userData?.name ? (
              <Avatar style={{ backgroundColor: "green" }} sx={{ mr: 2 }}>
                {getInitials(userData?.name)}
              </Avatar>
            ) : (
              <Avatar src="/broken-image.jpg" />
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default Navbar;
