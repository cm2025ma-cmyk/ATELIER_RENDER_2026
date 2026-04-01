import React, { useEffect, useState } from "react";
import { createRoot } from "react-dom/client";

function App() {
  const [info, setInfo] = useState(null);
  const [env, setEnv] = useState(null);

  useEffect(() => {
    // Remplace par ton URL Flask Render finale
    const API = "https://<ton-service-flask>.onrender.com";

    fetch(`${API}/info`)
      .then((res) => res.json())
      .then((data) => setInfo(data));

    fetch(`${API}/env`)
      .then((res) => res.json())
      .then((data) => setEnv(data));
  }, []);

  return (
    <div style={{ fontFamily: "sans-serif", padding: "20px" }}>
      <h1>Frontend Render → Flask</h1>

      <h2>Info</h2>
      <pre>{JSON.stringify(info, null, 2)}</pre>

      <h2>Environnement</h2>
      <pre>{JSON.stringify(env, null, 2)}</pre>
    </div>
  );
}

const root = createRoot(document.getElementById("root"));
root.render(<App />);
