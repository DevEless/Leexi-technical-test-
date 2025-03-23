<!-- pages/index.vue -->
<template>
    <div class="container">
      <h1>Calculateur de Prix d'Abonnement</h1>
      <!-- Formulaire de saisie -->
      <form @submit.prevent="calculatePrices">
        <div>
          <label for="plan">Plan :</label>
          <select id="plan" v-model="plan">
            <option value="ai_meeting">AI Meeting</option>
            <option value="enterprise">Enterprise</option>
          </select>
        </div>
        <div>
          <label for="licenses">Nombre de licences :</label>
          <input id="licenses" type="number" v-model.number="numberOfLicenses" min="1" required />
        </div>

        <button type="submit">Calculer</button>
      </form>
  
      <!-- Affichage des résultats -->
      <div v-if="prices" class="results">
  <h2>Résultat :</h2>
  <p>Coût mensuel total : <strong>{{ prices.monthly }} €</strong></p>
  <p>Coût annuel total : <strong>{{ prices.annually }} €</strong></p>
  <p v-if="plan === 'enterprise'"> Une remise de 10% a été appliquée pour le plan Enterprise</p>
</div>
      <!-- Message d'erreur éventuel -->
      <div v-if="error" class="error">
        <p style="color:red;">{{ error }}</p>
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref } from 'vue'
  
  // Données réactives du formulaire
  const plan = ref('ai_meeting')
  const numberOfLicenses = ref(1)
  const period = ref('monthly')
  
  // Données pour le résultat
  const prices = ref(null)
  const error = ref(null)
  
  // Fonction appelée lors de la soumission du formulaire
  async function calculatePrices() {
    error.value = null  // reset previous error
    prices.value = null // reset previous result
    try {
      const response = await fetch('http://localhost:8080/v1/prices', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          number_of_licenses: numberOfLicenses.value,
          plan: plan.value,
          period: period.value
        })
      })
      if (!response.ok) {
        // Si le statut HTTP n'est pas 200, on génère une erreur avec le message renvoyé par l’API
        const errorData = await response.json()
        throw new Error(errorData.error || 'Erreur lors de la récupération des prix')
      }
      const data = await response.json()
      prices.value = data.prices
    } catch (err) {
      error.value = err.message
    }
  }
  </script>
  
  <style>
  .container {
    max-width: 400px;
    margin: 2rem auto;
    font-family: sans-serif;
  }
  h1 {
    text-align: center;
    margin-bottom: 1.5rem;
  }
  form {
    border: 1px solid #ccc;
    padding: 1rem;
    border-radius: 5px;
  }
  form div {
    margin-bottom: 0.8rem;
  }
  label {
    display: inline-block;
    width: 130px;
  }
  input, select {
    padding: 0.25rem;
    font-size: 1em;
  }
  button {
    display: block;
    width: 100%;
    padding: 0.5rem;
    font-size: 1em;
    font-weight: bold;
    margin-top: 1rem;
    cursor: pointer;
  }
  .results {
    margin-top: 2rem;
    background: #f9f9f9;
    padding: 1rem;
    border-radius: 5px;
  }
  </style>
  