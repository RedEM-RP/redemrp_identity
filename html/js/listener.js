$(function(){
    window.onload = (e) => {
        window.addEventListener('message', (event) => {
                if (event.data.type == 1){
                    loadCharacters(event.data.list);
                    console.log(event.data.list);
            }
        });
    };
});