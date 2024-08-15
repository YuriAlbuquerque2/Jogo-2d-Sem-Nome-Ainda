/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Atualiza a posição dos créditos, fazendo-os subir
creditos_y -= velocidade_creditos;

// Se todos os créditos saírem da tela, você pode fazer algo, como mudar de room
if (creditos_y + array_length(creditos) * string_height("Example Text") < 0) {
    room_goto(rm_menu); // Por exemplo, muda de room quando os créditos terminam
}
