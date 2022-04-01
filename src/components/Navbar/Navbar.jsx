import React from "react";
import "./Navbar.scss";
import SearchOutlinedIcon from "@mui/icons-material/SearchOutlined";
import LanguageOutlinedIcon from "@mui/icons-material/LanguageOutlined";
import DarkModeOutlinedIcon from "@mui/icons-material/DarkModeOutlined";
import FullscreenExitOutlinedIcon from "@mui/icons-material/FullscreenExitOutlined";
import NotificationsNoneOutlinedIcon from "@mui/icons-material/NotificationsNoneOutlined";
import ChatBubbleOutlineOutlinedIcon from "@mui/icons-material/ChatBubbleOutlineOutlined";
import ListOutlinedIcon from "@mui/icons-material/ListOutlined";

const Navbar = () => {
  return (
    <div className="navbar">
      <div className="wrapper">
        <div className="search">
          <input type="text" placeholder="Search..." />
          <SearchOutlinedIcon classname="icon" />
        </div>
        <div className="items">
          <div className="item">
            <LanguageOutlinedIcon classname="icon" />
            <p>English</p>
          </div>
          <div className="item">
            <DarkModeOutlinedIcon classname="icon" />
          </div>
          <div className="item">
            <FullscreenExitOutlinedIcon classname="icon" />
          </div>
          <div className="item">
            <NotificationsNoneOutlinedIcon classname="icon" />
            <div className="counter">1</div>
          </div>
          <div className="item">
            <ChatBubbleOutlineOutlinedIcon classname="icon" />
            <div className="counter">2</div>
          </div>
          <div className="item">
            <ListOutlinedIcon classname="icon" />
          </div>
          <div className="item">
            <img
              src="
            https://images.pexels.com/photos/2531236/pexels-photo-2531236.jpeg?cs=srgb&dl=pexels-roberto-nickson-2531236.jpg&fm=jpg"
              alt=""
              className="avatar"
            />
          </div>
        </div>
      </div>
    </div>
  );
};

export default Navbar;
