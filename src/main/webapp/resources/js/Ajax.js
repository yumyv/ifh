class Ajax {
    static get(url, onsuccess) {
        const request = new XMLHttpRequest();
        request.open('GET', `${url}`, true);
        request.addEventListener('readystatechange', () => {
            if (request.readyState !== 4) return;
            if (request.status === 200) {
                onsuccess(request.responseText);
            } else {
                try {
                    request.send();
                } catch (e) {
                    return e.message;
                }
            }
        });
        request.send();
    }
}
