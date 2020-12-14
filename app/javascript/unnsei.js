window.onload = function(){
const btn = document.getElementById('btn')
const unnsei = document.getElementById('unnsei')
const results = ['大吉です','中吉です','吉です','小吉です','凶です'];
btn.addEventListener('click', function(){
unnsei.textContent = results[Math.floor(Math.random()*results.length)];
});
}