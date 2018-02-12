const closeAlert = () => {
  const obj = document.getElementById('alert');
  if(obj !== null) {
    obj.style.display = 'none';
  }
};

setTimeout(() => {
  closeAlert();
}, 5000);
