class Page {
    constructor() {
        this.modules = [];
    }

    registerModule(module) {
        this.modules.push(module);
    }

    init() {
        this.modules.forEach((m) => {
            m.init();
        });
    }

    start() {
        document.addEventListener('DOMContentLoaded', () => {
            this.init();
        });
    }
}

const page = new Page();
if (document.querySelector('.page-tab')) {
    page.registerModule(new TabsSwitcher(
        '.page-tab',
        'defaultOpenPageTab',
        '.page-tab__content',
        '.page-tab__link'
    ));
}
if (document.querySelector('.operation-tab')) {
    page.registerModule(new TabsSwitcher(
        '.operation-tab',
        'defaultOpenOperationTab',
        '.operation-tab__content',
        '.operation-tab__link'
    ));
}
if (document.querySelector('.exchange')) {
    page.registerModule(new Exchange('.exchange',
        '.row',
        'https://api.privatbank.ua/p24api/pubinfo?json&exchange&coursid=5'));
}
page.start();
