let btnVerificar = document.querySelector("#ba2");

btnVerificar.addEventListener("click", async function () {
    // Capturar o valor do campo CPF
    let cpf = document.querySelector("#cpf").value.trim();

    // Validação: CPF não pode ser vazio e deve ter exatamente 11 dígitos
    if (!cpf) {
        alert("O campo CPF não pode estar vazio.");
        return;
    }

    if (cpf.length !== 11 || isNaN(cpf)) {
        alert("CPF inválido. Certifique-se de que possui exatamente 11 dígitos numéricos.");
        return;
    }

    try {
        // Enviar requisição para o backend
        let response = await fetch("http://127.0.0.1:2000/verify-cpf", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ cpf: cpf }) // Envia o CPF no corpo da requisição
        });

        if (!response.ok) {
            throw new Error("Erro na requisição: " + response.status);
        }

        // Ler a resposta do backend
        let data = await response.json();

        if (data.message) {
            // Armazena o CPF no Session Storage
            sessionStorage.setItem("cpf", cpf);

            // Redirecionar para a página de pesquisa
            window.location.href = "pesquisa.html";
        } else {
            // CPF não encontrado no banco de dados
            alert("CPF não encontrado no banco de dados.");
        }
    } catch (error) {
        alert("Erro ao conectar ao servidor.");
    }
});


