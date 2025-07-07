<template>
  <div>
    <h1>Busca de Operadoras</h1>

    <input v-model="termo" @keyup.enter="buscar"  placeholder="Digite um termo..." />
    <button @click="buscar">Buscar</button>

    <ul>
      <li v-for="(item, i) in resultados" :key="i">
        <strong>{{ item.Nome_Fantasia || item.Razao_Social }}</strong><br>
        Registro ANS: {{ item.Registro_ANS }}<br>
        Cidade: {{ item.Cidade }} - {{ item.UF }}<br>
        E-mail: {{ item.Endereco_eletronico }}<br>
        Telefone: {{ item.DDD }} - {{ item.Telefone }}
      </li>
    </ul>
    
  </div>
</template>

<script>
export default {
  data() {
    return {
      termo: "",
      resultados: []
    }
  },
  methods: {
    async buscar() {
      const res = await fetch(`http://localhost:8000/buscar?termo=${this.termo}`);
      const data = await res.json();
      this.resultados = data;
    }
  }
}
</script>

<style scoped>
input {
  padding: 8px;
  margin-right: 8px;
}
button {
  padding: 8px 12px;
}
li {
  margin-bottom: 16px;
}
</style>
