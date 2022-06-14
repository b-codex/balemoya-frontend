import React, { useContext } from "react";
import "./Navbar.scss";
import SearchOutlinedIcon from "@mui/icons-material/SearchOutlined";
import LanguageOutlinedIcon from "@mui/icons-material/LanguageOutlined";
import DarkModeOutlinedIcon from "@mui/icons-material/DarkModeOutlined";
import FullscreenExitOutlinedIcon from "@mui/icons-material/FullscreenExitOutlined";
import NotificationsNoneOutlinedIcon from "@mui/icons-material/NotificationsNoneOutlined";
import ChatBubbleOutlineOutlinedIcon from "@mui/icons-material/ChatBubbleOutlineOutlined";
import ListOutlinedIcon from "@mui/icons-material/ListOutlined";
import { DarkModeContext } from "../../context/darkModeContext";
import { Avatar } from "@mui/material";
import { Link } from "react-router-dom";

const Navbar = () => {
  const { dispatch } = useContext(DarkModeContext);
  const signedIn = true;

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
            <FullscreenExitOutlinedIcon className="icon" />
          </div>
          <Link to="/notifications" style={{ textDecoration: "none", color: "inherit" }}>
            <div className="item">
              <NotificationsNoneOutlinedIcon className="icon" />
              <div className="counter">1</div>
            </div>
          </Link>

          <div className="item">
            {signedIn ? (
              <Avatar
                style={{ backgroundColor: "orange" }}
                alt="Remy Sharp"
                src="/broken-image.jpg"
              >
                A
                {/* TODO:  use prop to pass down the initials from the admin's name (from sign in page) */}
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
