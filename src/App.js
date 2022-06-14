import React from "react";
import { render } from "react-dom";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Home from "./pages/home/Home";
import Login from "./pages/login/Login";
import Single from "./pages/singleUser/Single";
import SingleJob from "./pages/singleJob/SingleJob";
import JobList from "./pages/job/JobList";
import List from "./pages/userList/List";
import ReportList from "./pages/reportList/ReportList";
import SingleReport from "./pages/singleReport/SingleReport";
import NotificationsList from "./pages/notificationsList/NotificationsList";
import "antd/dist/antd.css";
import store from "./redux/store";
import { Provider, useSelector } from "react-redux";
import { PersistGate } from "redux-persist/integration/react";
import { persistStore } from "redux-persist";
let persistor = persistStore(store);

function App() {
  return (
    <Provider store={store}>
      <PersistGate loading={null} persistor={persistor}>
        <div className="App">
          <BrowserRouter>
            <Routes>
              <Route path="/">
                <Route index element={<Home />} />
                <Route path="login" element={<Login />} />
                {/* <Route path="jobs" element={<JobList />} /> */}
                <Route path="users">
                  <Route index element={<List />} />
                  <Route path=":userId" element={<Single />} />
                </Route>
                <Route path="notifications">
                  <Route index element={<NotificationsList />} />
                </Route>
                <Route path="jobs">
                  <Route index element={<JobList />} />
                  <Route path=":jobId" element={<SingleJob />} />
                </Route>
                <Route path="reports">
                  <Route index element={<ReportList />} />
                  <Route path=":reportId" element={<SingleReport />} />
                </Route>
              </Route>
            </Routes>
          </BrowserRouter>
        </div>
      </PersistGate>
    </Provider>
  );
}

export default App;
