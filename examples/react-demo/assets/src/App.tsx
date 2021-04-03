import React, { useState, useEffect } from "react";

export function App() {
  let images = ["180116", "180311", "180548", "184010"];
  let imgContainers = images.map((value, idx) => {
    return (
      <img
        key={idx}
        src={`/images/${value}.jpg`}
        height={100}
        style={{ padding: 5 }}
      />
    );
  });
  return (
    <>
      <p>Hello Vite + React!</p>
      {imgContainers}
      <br />
      <img
        src="/images/phoenix.png"
        height={50}
        style={{ padding: 10, background: "" }}
      />
    </>
  );
}
