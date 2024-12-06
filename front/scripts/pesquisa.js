document.addEventListener("DOMContentLoaded", function() {
    // Recuperar CPF do sessionStorage
    const cpf = sessionStorage.getItem("cpf");
    console.log(cpf);

    if (!cpf) {
        alert("Erro: CPF não encontrado.");
    } else {
        // Fazer a requisição POST para a API de Atleta
        fetch("http://127.0.0.1:2000/get-atleta-infos", {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ cpf: cpf })
        })
        .then(response => {
            if (!response.ok) {
                throw new Error("Erro ao fazer a requisição de dados do atleta.");
            }
            return response.json();
        })
        .then(data => {
            if (data.message) {
                // Dados do atleta
                const atleta = {
                    nome: data.nome,
                    genero: data.genero,
                    cpf: data.cpf,
                    idade: data.idade,
                    endereco: data.endereco,
                    telefone: data.telefone,
                    universidade: data.universidade,
                    curso: data.curso
                };

                // Preenchendo os dados do atleta no HTML
                document.getElementById("atleta-nome").textContent = atleta.nome;
                document.getElementById("atleta-genero").textContent = atleta.genero;
                document.getElementById("atleta-cpf").textContent = atleta.cpf;
                document.getElementById("atleta-idade").textContent = atleta.idade;
                document.getElementById("atleta-endereco").textContent = atleta.endereco;
                document.getElementById("atleta-telefone").textContent = atleta.telefone;

                // Requisição POST para buscar os times
                fetch("http://127.0.0.1:2000/times", {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({
                        genero: atleta.genero,  // Passando o gênero do atleta
                        universidade: atleta.universidade,  // Substitua pela universidade do atleta
                        nome_curso: atleta.curso      // Substitua pelo nome do curso
                    })
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error("Erro ao fazer a requisição de dados dos times.");
                    }
                    return response.json();
                })
                .then(timesData => {
                    if (timesData.message && Array.isArray(timesData.times)) {
                        // Preenchendo a tabela com os times
                        preencherTabela(timesData.times);
                    } else {
                        alert("Erro ao recuperar dados dos times.");
                    }
                })
                .catch(error => {
                    console.error("Erro ao fazer a requisição dos times:", error);
                    alert(`Erro ao recuperar dados dos times: ${error.message}`);
                });

                // Função para preencher a tabela com os times
                function preencherTabela(times) {
                    const tabela = document.getElementById("tabela-times").getElementsByTagName("tbody")[0];

                    if (times.length === 0) {
                        // Caso não haja times, exibe uma mensagem
                        const row = tabela.insertRow();
                        const cell = row.insertCell(0);
                        cell.colSpan = 5; // Mescla todas as colunas
                        cell.style.textAlign = "center";
                        cell.textContent = "Nenhum time disponível.";
                    } else {
                        times.forEach(time => {
                            const row = tabela.insertRow();
                            row.insertCell(0).textContent = time.esporte;
                            row.insertCell(1).textContent = time.universidade;
                            row.insertCell(2).textContent = time.treinador;
                            row.insertCell(3).textContent = time.genero;
                            row.insertCell(4).textContent = time.organizacao;
                        });
                    }
                }
            } else {
                alert("Erro ao recuperar dados do atleta.");
            }
        })
        .catch(error => {
            console.error("Erro ao fazer a requisição:", error);
            alert(`Erro ao recuperar dados do atleta: ${error.message}`);
        });
    }
});
