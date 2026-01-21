import { useState } from "react";
import { login } from "../services/api";
import "../App.css";

export default function Login() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [message, setMessage] = useState("");

  async function handleLogin(e: React.FormEvent) {
    e.preventDefault();

    try {
      const result = await login(email, password);
      setMessage(result.message || "Login exitoso");
    } catch (error) {
      setMessage("Error al iniciar sesión");
    }
  }

  return (
    <div className="container">
      <div className="card">
        <h2>Login</h2>

        <form onSubmit={handleLogin}>
          <input
            type="email"
            placeholder="Correo"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
          />

          <br /><br />

          <input
            type="password"
            placeholder="Contraseña"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
          />

          <br /><br />

          <button type="submit">Ingresar</button>
        </form>

        {message && <p>{message}</p>}
      </div>
    </div>
  );
}
