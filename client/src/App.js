import React, { useState, useEffect } from "react";
import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap/dist/js/bootstrap.min.js";
import {
  BrowserRouter as Router,
  Routes,
  Route,
  Navigate,
} from "react-router-dom";
import Login from "./components/Login";
import Signup from "./components/Signup";
import HomeAdmin from "./components/HomeAdmin";
import OtpConfirm from "./components/OtpConfirm";

import Shift from "./components/Shift";
import FCviews from "./components/FCviews";
import SendToManager from "./components/SendToManager";
import ManagerView from "./components/ManagerView";
import UpdateStatusFC from "./components/UpdateStatusFC";
import FcCheck from "./components/FcCheck";
import FcCheckDetail from "./components/FcCheckDetail";
import InfoModal from "./components/InfoModal";

import HomeFc from "./components/HomeFc";
import HomeManager from "./components/HomeManager";
import HomeEmployee from "./components/HomeEmployee";

import NavbarAdmin from "./components/navbar/NavbarAdmin";
import NavbarEmployee from "./components/navbar/NavbarEmployee";
import NavbarManager from "./components/navbar/NavbarManager";
import NavbarFc from "./components/navbar/NavbarFc";
import { Outlet } from "react-router-dom";

import TimeManager from "./components/timeManager";
import AbsenceManagePage from "./components/absenceManagePage";
import AbsenceEditEmp from "./components/absenceEditEmp";
import AbsenceSum from "./components/absenceSum";
import AbsenceSelect from "./components/absenceSelect";
import LeaveFormEmPage from "./components/leaveFormEmPage";
import LeaveFormMgPage from "./components/leaveFormMgPage";
import AddShiftPage from "./components/addShiftPage";
import AddShiftDetailPage from "./components/addShiftDetailPage";
import ShiftManagementPage from "./components/shiftManagementPage";

import EditUser from "./components/EditUser";

const AppLayoutAdmin = ({ handleLogout, children }) => (
  <>
    <NavbarAdmin handleLogout={handleLogout} />
    <Outlet />
  </>
);

const AppLayoutEmployee = ({ handleLogout, children }) => (
  <>
    <NavbarEmployee handleLogout={handleLogout} />
    <Outlet />
  </>
);

const AppLayoutManager = ({ handleLogout, children }) => (
  <>
    <NavbarManager handleLogout={handleLogout} />
    <Outlet />
  </>
);

const AppLayoutFc = ({ handleLogout, children }) => (
  <>
    <NavbarFc handleLogout={handleLogout} />
    <Outlet />
  </>
);

const App = () => {
  const [user, setUser] = useState(null);
  const [navigate, setNavigate] = useState(false);

  useEffect(() => {
    const loggedInUser = localStorage.getItem("user");
    if (loggedInUser) {
      setUser(JSON.parse(loggedInUser));
      setNavigate(true);
    }
  }, []);

  const handleLogout = () => {
    if (window.confirm("Are you sure you want to log out?")) {
      setUser(null);
      localStorage.removeItem("user");
      return <Navigate to="/" />;
    } else {
      return null;
    }
  };
  const getRedirectPath = (user) => {
    switch (user.roleID) {
      case "1":
        return "/homeAdmin";
      case "2":
        return "/homeManager";
      case "3":
        return "/homeEmployee";
      case "4":
        return "/homeFc";
      default:
        return "/";
    }
  };
  return (
    <Router>
      {navigate && <Navigate to={getRedirectPath(user)} />}
      <Routes>
        <Route
          path="/"
          element={
            !user ? (
              <Login setUser={setUser} />
            ) : (
              <Navigate to={getRedirectPath(user)} />
            )
          }
        />

        {/* Admin Routes */}
        {user && user.roleID === "1" && (
          <Route element={<AppLayoutAdmin handleLogout={handleLogout} />}>
            <Route path="/homeAdmin" element={<HomeAdmin user={user} />} />
            <Route path="/signup" element={<Signup user={user} />} />
            <Route path="/adminShift" element={<Shift user={user} />} />
            <Route path="/EditUser/:id" element={<EditUser />} />
            <Route path="/otpConfirm" element={<OtpConfirm />} />
          </Route>
        )}

        {/* Employee Routes */}
        {user && user.roleID === "3" && (
          <Route element={<AppLayoutEmployee handleLogout={handleLogout} />}>
            <Route
              path="/homeEmployee"
              element={<HomeEmployee user={user} />}
            />
            <Route path="/employeeShift" element={<Shift user={user} />} />

            <Route
              path="/leaveFormEmPage"
              element={<LeaveFormEmPage user={user} />}
            />
          </Route>
        )}

        {user && user.roleID === "2" && (
          <Route element={<AppLayoutManager handleLogout={handleLogout} />}>
            <Route path="/homeManager" element={<HomeManager user={user} />} />
            <Route path="/employeeShift" element={<Shift user={user} />} />
            <Route path="/ManagerView" element={<ManagerView user={user} />} />
            <Route
              path="/ManagerView/sendFC/:absenceID"
              element={<InfoModal user={user} />}
            />

            <Route path="/timeManager" element={<TimeManager user={user} />} />

            <Route
              path="/absenceManagePage/absenceSum"
              element={<AbsenceSum user={user} />}
            />
            <Route
              path="/absenceManagePage/absenceSelect"
              element={<AbsenceSelect user={user} />}
            />
            <Route
              path="/absenceManagePage/absenceEditEmp"
              element={<AbsenceEditEmp user={user} />}
            />
            <Route
              path="/absenceManagePage"
              element={<AbsenceManagePage user={user} />}
            />

            <Route
              path="/leaveFormMgPage"
              element={<LeaveFormMgPage user={user} />}
            />
            <Route
              path="/shiftManagementPage"
              element={<ShiftManagementPage user={user} />}
            />
            <Route
              path="/shiftManagementPage/addShiftPage"
              element={<AddShiftPage user={user} />}
            />
            <Route
              path="/shiftManagementPage/addShiftDetailPage"
              element={<AddShiftDetailPage user={user} />}
            />
          </Route>
        )}

        {user && user.roleID === "4" && (
          <Route element={<AppLayoutFc handleLogout={handleLogout} />}>
            <Route path="/FcView" element={<FCviews user={user} />} />
            <Route path="/homeFc" element={<HomeFc user={user} />} />
            <Route path="/FcView" element={<FCviews user={user} />} />
            <Route
              path="/FcView/send/:absenceID"
              element={<SendToManager user={user} />}
            />
            <Route path="/FcCheck" element={<FcCheck user={user} />}></Route>
            <Route
              path="/FcCheck/send/:absenceID"
              element={<FcCheckDetail user={user} />}
            />
            <Route
              path="/FcView/UpdateStatusFC/:absenceID"
              element={<UpdateStatusFC user={user} />}
            />
          </Route>
        )}
      </Routes>
    </Router>
  );
};

export default App;
