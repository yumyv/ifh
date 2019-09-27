class Exchange extends Module {
    constructor(selector, outputSelector, url) {
        super(selector);
        this.outputSelector = outputSelector;
        this.url = url;
    }

    onCreate() {
        this.output();
    }

    output() {
        Ajax.get(this.url, (response) => {
            const result = JSON.parse(response);
            const list = document.createElement('ul');
            list.classList.add('exchange__list');
            result.forEach((r)=>{
                const item = document.createElement('li');
                item.classList.add('exchange__item');
                item.innerText = `${r.ccy}: ${Number(r.buy).toFixed(3)}/${Number(r.sale).toFixed(3)}`;
                list.append(item);
            });
            this.container.querySelector(this.outputSelector).append(list);
        })
    }
}