let btnInscrever = document.querySelector("#ba1");

// Arrays para armazenar os dados dos atletas
let atletas = [];

// Função para validar o ano de ingresso
function validarAno(ano) {
    const anoAtual = new Date().getFullYear();
    return ano > 1900 && ano <= anoAtual;
}

// Função para carregar cursos com base no código da universidade
async function carregarCursos(universidadeCodigo) {
    try {
        // Verifica se o código da universidade foi fornecido
        if (!universidadeCodigo) {
            alert("Por favor, selecione uma universidade.");
            return;
        }

        // Faz a requisição para obter os cursos com base no código da universidade
        const response = await fetch(`http://127.0.0.1:2000/cursos?universidade_codigo=${universidadeCodigo}`);

        // Verifica se a resposta foi bem-sucedida
        if (!response.ok) {
            // Tenta extrair a mensagem de erro do corpo da resposta
            const errorData = await response.json();
            const errorMessage = errorData.detail || "Erro desconhecido ao buscar cursos";
            throw new Error(errorMessage);
        }

        const data = await response.json();

        // Verifica se a resposta contém os dados esperados
        if (!data.message) {
            throw new Error("Dados inválidos recebidos do servidor.");
        }

        const selectCurso = document.querySelector("#curso");

        // Limpando o dropdown antes de preencher
        selectCurso.innerHTML = "<option value=''>Selecione um curso</option>";

        // Preenchendo as opções com os cursos retornados
        data.message.forEach((curso) => {
            const option = document.createElement("option");
            option.value = curso.NOME; // O valor da opção será o nome do curso
            option.textContent = curso.NOME;  // Texto exibido será o nome do curso
            selectCurso.appendChild(option);
        });
    } catch (error) {
        console.error("Erro ao carregar cursos:", error);
        
        // Exibe o erro para o usuário
        alert(`Erro ao carregar cursos: ${error.message}`);
    }
}

// Evento que será disparado quando a universidade for selecionada
document.querySelector("#universidade").addEventListener("change", function() {
    const universidadeCodigo = this.value; // Pega o código da universidade selecionada
    carregarCursos(universidadeCodigo); // Chama a função para carregar os cursos
});

async function carregarUFs() {
    try {
        const response = await fetch("http://127.0.0.1:2000/uf-code");

        // Verificar se a resposta foi bem-sucedida
        if (!response.ok) {
            const errorData = await response.json();
            throw new Error(errorData.detail || "Erro ao buscar UFs");
        }

        const data = await response.json();

        // Verifica se os dados recebidos são válidos
        if (!data.message) {
            throw new Error("Dados inválidos recebidos do servidor.");
        }

        const selectUF = document.querySelector("#uf");

        // Limpando o dropdown antes de preencher
        selectUF.innerHTML = "<option value=''>Selecione um estado (UF)</option>";

        // Preenchendo as opções com os dados retornados
        data.message.forEach((uf) => {
            const option = document.createElement("option");
            option.value = uf.CODIGO_UF; // Código como valor
            option.textContent = uf.SIGLA; // Sigla como texto exibido
            selectUF.appendChild(option);
        });
    } catch (error) {
        console.error("Erro ao carregar UFs:", error);
        
        // Exibe a mensagem de erro para o usuário
        alert(`Erro ao carregar UFs: ${error.message}`);
    }
}

// Função para buscar universidades do backend
async function carregarUniversidades() {
    try {
        // Fazendo a requisição GET para a rota de universidades
        const response = await fetch("http://127.0.0.1:2000/universidades"); // Ajuste o URL se necessário
        if (!response.ok) {
            throw new Error("Erro ao buscar universidades");
        }

        const data = await response.json();

        // Obtendo o elemento <select> do HTML
        const selectUniversidade = document.querySelector("#universidade");

        // Limpando o select antes de adicionar os novos dados
        selectUniversidade.innerHTML = "<option value=''>Selecione uma universidade</option>";

        // Iterando sobre os dados recebidos para criar as opções
        data.message.forEach((uni) => {
            const option = document.createElement("option");
            option.value = uni.CODIGO_MEC; // Valor será o código MEC
            option.textContent = uni.NOME; // Texto exibido será o nome da universidade
            selectUniversidade.appendChild(option);
        });
    } catch (error) {
        console.error("Erro ao carregar universidades: ", error.detail);
        alert("Erro ao carregar universidades: ", error.detail);
    }
}

// Adicionar novo atleta ao clicar no botão "Inscrever"
btnInscrever.addEventListener("click", async function () {
    // Capturando os valores dos campos do formulário
    let cpf = document.querySelector("#cpf").value.trim();
    let nome = document.querySelector("#nome").value.trim();
    let genero = document.querySelector("#genero").value.trim().toUpperCase();
    let idade = document.querySelector("#idade").value.trim();
    let rua = document.querySelector("#rua").value.trim();
    let bairro = document.querySelector("#bairro").value.trim();
    let numero = document.querySelector("#numero").value.trim();
    let cidade = document.querySelector("#cidade").value.trim();
    let uf = document.querySelector("#uf").value.trim().toUpperCase();
    let telefone = document.querySelector("#telefone").value.trim();
    let codigoMatricula = document.querySelector("#codigo_matricula").value.trim();
    let anoIngresso = document.querySelector("#ano_ingresso").value.trim();
    let universidade = document.querySelector("#universidade").value.trim();
    let curso = document.querySelector("#curso").value.trim();

    // Validações (mantidas do código anterior)
    if (!cpf || cpf.length !== 11 || isNaN(cpf)) {
        alert("CPF inválido. Certifique-se de que tem 11 dígitos e não está vazio.");
        return;
    }
    // (As outras validações seguem iguais...)

    // Criando o objeto para enviar ao backend
    let atleta = {
        cpf,
        nome,
        genero,
        idade: parseInt(idade),
        rua,
        bairro,
        numero: parseInt(numero),
        cidade,
        uf,
        telefone,
        codigo_matricula: codigoMatricula,
        ano_ingresso: parseInt(anoIngresso),
        universidade,
        nome_curso: curso,
    };

    // Fazendo a requisição POST para o backend
    try {
        const response = await fetch("http://127.0.0.1:2000/insert-atleta", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(atleta),
        });

        if (!response.ok) {
            const errorData = await response.json(); // Obtém o corpo da resposta com detalhes do erro
            if (errorData && errorData.detail) {
                // Exibe a mensagem detalhada do backend
                alert(`Erro ao inscrever atleta: ${errorData.detail}`);
                console.error("Erro do backend:", errorData.detail);
            } else {
                // Caso a mensagem detalhada não esteja disponível
                throw new Error(`Erro na requisição: ${response.status}`);
            }
            return;
        }

        // Sucesso: Lida com a resposta do backend
        const data = await response.json();
        alert("Atleta inscrito com sucesso!");
        console.log("Resposta do backend:", data);

        // Limpando os campos do formulário
        document.querySelectorAll(".form-control").forEach((input) => {
            input.value = "";
        });
    } catch (error) {
        // Lida com erros inesperados
        alert(`Erro ao inscrever atleta: ${error.message}`);
        console.error("Erro inesperado:", error);
    }
});


// document.addEventListener("DOMContentLoaded", function() {
//     carregarUFs();
//     carregarUniversidades();
// });

document.addEventListener("DOMContentLoaded", function () {
    carregarUFs();
    carregarUniversidades();

    // Referências aos campos
    const universidadeSelect = document.querySelector("#universidade");
    const cursoContainer = document.querySelector("#curso-container");

    // Evento para mostrar o campo de curso quando uma universidade for selecionada
    universidadeSelect.addEventListener("change", function () {
        if (this.value) {
            // Mostra o campo curso
            cursoContainer.classList.remove("d-none");
        } else {
            // Esconde o campo curso
            cursoContainer.classList.add("d-none");
        }
    });

    // Adiciona validação antes do envio do formulário
    const btnInscrever = document.querySelector("#ba1");
    btnInscrever.addEventListener("click", function (event) {
        const universidadeValue = universidadeSelect.value;
        const cursoValue = document.querySelector("#curso").value;

        if (!universidadeValue || !cursoValue) {
            event.preventDefault(); // Impede o envio do formulário
            alert("Por favor, selecione tanto a universidade quanto o curso.");
        }
    });
});
