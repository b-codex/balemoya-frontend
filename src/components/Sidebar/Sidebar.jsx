import React, { useContext } from "react";
import "./Sidebar.scss";
import DashboardIcon from "@mui/icons-material/Dashboard";
import PersonOutlineOutlinedIcon from "@mui/icons-material/PersonOutlineOutlined";
import StoreMallDirectoryOutlinedIcon from "@mui/icons-material/StoreMallDirectoryOutlined";
import CreditCardOutlinedIcon from "@mui/icons-material/CreditCardOutlined";
import LocalShippingOutlinedIcon from "@mui/icons-material/LocalShippingOutlined";
import InsertChartOutlinedIcon from "@mui/icons-material/InsertChartOutlined";
import NotificationsNoneOutlinedIcon from "@mui/icons-material/NotificationsNoneOutlined";
import SettingsSystemDaydreamOutlinedIcon from "@mui/icons-material/SettingsSystemDaydreamOutlined";
import PsychologyOutlinedIcon from "@mui/icons-material/PsychologyOutlined";
import SettingsOutlinedIcon from "@mui/icons-material/SettingsOutlined";
import PermIdentityOutlinedIcon from "@mui/icons-material/PermIdentityOutlined";
import LogoutOutlinedIcon from "@mui/icons-material/LogoutOutlined";
import { Link } from "react-router-dom";
import { DarkModeContext } from "../../context/darkModeContext";

const Sidebar = () => {
  const { dispatch } = useContext(DarkModeContext);
  return (
    <div className="sidebar">
      <div className="top">
        <span className="admin_logo">Admin</span>
      </div>
      <hr />
      <div className="center">
        <ul>
          <p className="title">MAIN</p>
          <Link to="/" style={{ textDecoration: "none", color: "inherit" }}>
            <li>
              <DashboardIcon /> <span>Dashboard</span>
            </li>
          </Link>

          <p className="title">ACCOUNT MANAGEMENT</p>
          <Link

            to="/users"
            style={{ textDecoration: "none", color: "inherit" }}
          >
            <li>
              <PersonOutlineOutlinedIcon /> <span>Users</span>
            </li>
          </Link>

          <p className="title">USEFUL</p>
          <li>
            <InsertChartOutlinedIcon /> <span>Stats</span>
          </li>
          <li>
            <NotificationsNoneOutlinedIcon /> <span>Notifications</span>
          </li>
          <p className="title">SERVICE</p>
          {/* <li>
            <SettingsSystemDaydreamOutlinedIcon /> <span>System Health</span>
          </li> */}
          <li>
            <PsychologyOutlinedIcon /> <span>Logs</span>
          </li>
          <li>
            <SettingsOutlinedIcon /> <span>Settings</span>
          </li>
          <p className="title">USER</p>
          <li>
            <PermIdentityOutlinedIcon /> <span>Profile</span>
          </li>
          <li>
            <LogoutOutlinedIcon /> <span>Logout</span>
          </li>
        </ul>
      </div>
      <div className="bottom">
        {/* color options */}
        <span
          className="color_options"
          onClick={() => dispatch({ type: "LIGHT" })}
        ></span>
        <span
          className="color_options"
          onClick={() => dispatch({ type: "DARK" })}
        ></span>
      </div>
    </div>
  );
};

export default Sidebar;
