import { Amplify } from 'aws-amplify';
import '@aws-amplify/ui-react/styles.css';
import '@fontsource-variable/inter';
import './App.css';

import { Routes, Route } from "react-router-dom";

import { Authenticator, ThemeProvider } from '@aws-amplify/ui-react';
import theme from "./theme";
import Layout from './layout/Layout';
import Home from "./pages/Home";
import Play from "./pages/Play";
import NoPage from "./pages/NoPage";
import Login from "./pages/Login"
import Download from "./pages/Download"


import ProtectedRoute from './components/ProtectedRoute';
// import ProtectedPage from './components/ProtectedPage';

import outputs from "./amplify_outputs.json";

Amplify.configure(outputs);

function App() {
  return (
    <Authenticator.Provider>
      <ThemeProvider theme={theme}>
          <Routes>
            <Route path="/game" index></Route>
            <Route path="/" element={<Layout />}>
              <Route index element={<Home />} />
              <Route path="login" element={<Login />} />
              <Route path="play" element={
                <ProtectedRoute>
                  <Play />
                </ProtectedRoute>
              }
              />
              <Route path="download" element={
                <ProtectedRoute>
                  <Download />
                </ProtectedRoute>
              }
              />
              <Route path="*" element={<NoPage />} />
            </Route>
          </Routes>
      </ThemeProvider>
    </Authenticator.Provider>

  );
}

export default App;
