document.querySelector("#subscribeBtn").onclick = (e) => {
  e.preventDefault();
  document.querySelector(".modal-follow").style.display = "flex";
};
function closeFollow() {
  document.querySelector(".modal-follow").style.display = "none";
}
document.querySelector(".modal-follow").addEventListener("click", (e) => {
  if (e.target.tagName !== "BUTTON") {
    document.querySelector(".modal-follow").style.display = "none";
  }
});
function popup(obj) {
  console.log(obj);
  document.querySelector(obj).style.display = "flex";
}
function closePopup(obj) {
  console.log(2);
  document.querySelector(obj).style.display = "none";
}
document.querySelector(".modal-info").addEventListener("click", (e) => {
  if (e.target.tagName === "DIV") {
    document.querySelector(".modal-info").style.display = "none";
  }
});
document.querySelector(".modal-image").addEventListener("click", (e) => {
  if (e.target.tagName === "DIV") {
    document.querySelector(".modal-image").style.display = "none";
  }
});
function clickFollow(e) {
  console.log(e);
  let _btn = e;
  console.log(_btn.textContent);
  if (_btn.textContent === "구독취소") {
    _btn.textContent = "구독하기";
    _btn.style.backgroundColor = "#fff";
    _btn.style.color = "#000";
    _btn.style.border = "1px solid #ddd";
  } else {
    _btn.textContent = "구독취소";
    _btn.style.backgroundColor = "#0095f6";
    _btn.style.color = "#fff";
    _btn.style.border = "0";
  }
}