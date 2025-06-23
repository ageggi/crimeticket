const container = document.getElementById("tickets-container");

window.addEventListener('message', function(event) {
    let data = event.data;
    if (data.type === "showTicket") {
        addCrimeTicket(data);
    }
    if (data.type === "closeTopTicket") {
        closeTopTicket();
    }
});

function addCrimeTicket(data) {
    const el = document.createElement("div");
    el.className = "crime-ticket";
    el.id = "ticket_" + data.ticketId;
    el.innerHTML = `
        <div class="title">Крайм-тикет!</div>
        <div class="desc">Игрок <b>${data.idcard}</b> под ID <b>${data.id}</b> (${data.name}) отправил вам крайм-тикет, проследите за ним.</div>
        <div class="hint">Чтобы закрыть это окно — нажмите BackSpace</div>
    `;
    container.appendChild(el);
}

function closeTopTicket() {
    const tickets = container.getElementsByClassName("crime-ticket");
    if (tickets.length > 0) {
        const el = tickets[tickets.length - 1];
        if (el) {
            el.style.opacity = "0";
            setTimeout(() => {
                el.remove();
            }, 200);

            axios.post(`https://${GetParentResourceName()}/closeTicket`, {
                ticketId: el.id.replace("ticket_", "")
            });
        }
    }
}

document.onkeyup = function(data) {
    if(data.which == 8) {
        closeTopTicket();
    }
}