var Dialog = function (htmlElem) {
    var container = document.createElement('div');

    htmlElem.classList.add('modal-frame');
    container.className = "modal-container";

    container.appendChild(htmlElem);

    container.onclick = () => {
        this.cancel();
    }

    $(container).children().click((e) => {
        e.stopPropagation();
    });

    this.value = null;

    this.onsubmit = function () {};
    this.oncancel = function () { };

    var close = function () {
        htmlElem.classList.remove("fadein");
        if (container.parentElement != null) {
            container.parentElement.removeChild(container);
        }
    }

    this.cancel = () => {
        this.oncancel();
        close();
    }

    this.submit = () => {
        this.onsubmit(this.value);
        close();
    }

    this.open = () => {
        if (container.parentElement == null) {
            document.body.appendChild(container);
            setTimeout(() => {
                htmlElem.classList.add("fadein");
            });
        }
    }
}