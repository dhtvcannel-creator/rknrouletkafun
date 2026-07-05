<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1.0, minimum-scale=1.0, viewport-fit=cover">
  <title>РКН-Рулетка · Высшая мера для интернета</title>
  
  <!-- СРАЗУ ПРОВЕРЯЕМ, НЕ ВО ФРЕЙМЕ ЛИ МЫ (MIMO) -->
  <script>
    // Если страница внутри фрейма — вырываемся наверх
    if (window.top !== window.self) {
      window.top.location = window.self.location;
    }
  </script>
  
  <!-- Подключаем иконочный шрифт для деталей -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      background: radial-gradient(circle at 20% 10%, #121826 0%, #03050b 100%);
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      font-family: 'Inter', 'Segoe UI', system-ui, -apple-system, sans-serif;
      padding: 1.2rem;
      margin: 0;
      user-select: none;
      -webkit-tap-highlight-color: transparent;
    }

    /* Главная капсула в стиле секретного терминала */
    .rkn-terminal {
      max-width: 750px;
      width: 100%;
      background: rgba(8, 12, 24, 0.8);
      backdrop-filter: blur(20px) saturate(190%);
      border-radius: 3.5rem;
      padding: 2rem 2rem 2.4rem;
      box-shadow: 
        0 30px 50px rgba(0,0,0,0.7),
        inset 0 0 0 1px rgba(212, 40, 60, 0.5),
        0 0 25px rgba(200, 40, 40, 0.25);
      border: 1px solid rgba(220, 60, 80, 0.45);
      transition: all 0.3s ease;
    }

    .emblem {
      text-align: center;
      margin-bottom: 1.8rem;
      border-bottom: 2px solid #b71c2c;
      padding-bottom: 1.2rem;
      position: relative;
    }

    .double-eagle {
      font-size: 1.8rem;
      color: #d4af37;
      opacity: 0.9;
      text-shadow: 0 0 10px #b71c2c;
      letter-spacing: 6px;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
      margin-bottom: 0.5rem;
    }

    .department-badge {
      background: #1f0a10;
      padding: 0.35rem 2rem;
      border-radius: 4rem;
      font-weight: 700;
      font-size: 0.8rem;
      letter-spacing: 3px;
      color: #ffb7a0;
      border: 1px solid #b91c2c;
      display: inline-block;
      text-transform: uppercase;
      margin-bottom: 1rem;
    }

    h1 {
      font-size: 2.4rem;
      font-weight: 850;
      background: linear-gradient(180deg, #f0f0ff 0%, #cdcdff 90%);
      background-clip: text;
      -webkit-background-clip: text;
      color: transparent;
      text-shadow: 0 0 12px rgba(255, 80, 80, 0.3);
      line-height: 1.2;
      margin: 0.5rem 0 0.2rem;
    }

    .sub-header {
      color: #9097b5;
      font-weight: 500;
      font-size: 0.9rem;
      display: flex;
      justify-content: center;
      gap: 0.8rem;
      flex-wrap: wrap;
    }

    /* Поле рулетки с кольцом */
    .roulette-stage {
      margin: 1.6rem 0 2rem;
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    .wheel-container {
      background: #02040e;
      border-radius: 3.2rem;
      padding: 1.6rem 1.2rem 1.2rem;
      width: 100%;
      box-shadow: inset 0 0 25px rgba(0,0,0,0.9), 0 20px 30px rgba(0,0,0,0.5);
      border: 1px solid #403e55;
      position: relative;
      text-align: center;
    }

    .target-display {
      background: #050714;
      border-radius: 2.5rem;
      padding: 1rem 1.2rem;
      margin-bottom: 1.4rem;
      border: 1px solid #6d3040;
    }

    .stamp {
      font-weight: 700;
      font-size: 0.85rem;
      background: #1d0f18;
      display: inline-block;
      padding: 0.3rem 2rem;
      border-radius: 5rem;
      color: #fca06e;
      text-transform: uppercase;
      border-left: 5px solid #e63946;
      letter-spacing: 2px;
    }

    .app-name {
      font-size: 3.5rem;
      font-weight: 900;
      background: linear-gradient(135deg, #ff7b6b, #e63946);
      background-clip: text;
      -webkit-background-clip: text;
      color: transparent;
      margin: 0.8rem 0 0.5rem;
      word-break: break-word;
      text-shadow: 0 0 20px #ff3b3f;
      line-height: 1.1;
      transition: 0.2s;
    }

    .roulette-slot-machine {
      display: flex;
      justify-content: center;
      gap: 0.4rem;
      margin: 0.7rem 0;
      flex-wrap: wrap;
    }

    .slot-item {
      background: #1a1224;
      color: #f05454;
      font-weight: bold;
      padding: 0.2rem 1rem;
      border-radius: 2rem;
      font-size: 0.85rem;
    }

    .execution-btn {
      background: linear-gradient(145deg, #b71c2c, #7f1220);
      border: none;
      width: 85%;
      font-size: 1.8rem;
      font-weight: 800;
      color: #ffffff;
      padding: 1.1rem 0.8rem;
      border-radius: 5rem;
      cursor: pointer;
      text-transform: uppercase;
      letter-spacing: 3px;
      margin: 0.8rem 0 0.3rem;
      box-shadow: 0 10px 0 #3d0912, 0 12px 25px black;
      transition: all 0.08s linear;
      border: 1px solid #ff5e5e;
      font-family: inherit;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.4rem;
    }

    .execution-btn:active {
      transform: translateY(5px);
      box-shadow: 0 4px 0 #3d0912, 0 8px 15px black;
    }

    .execution-btn:disabled {
      opacity: 0.7;
      transform: translateY(2px);
      box-shadow: 0 6px 0 #3d0912;
      filter: grayscale(0.3);
    }

    .history-panel {
      background: rgba(0, 0, 0, 0.55);
      border-radius: 2.2rem;
      padding: 1.2rem 1.2rem;
      margin-top: 1.5rem;
      backdrop-filter: blur(10px);
    }

    .history-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      color: #dcdcf0;
      font-weight: 600;
      margin-bottom: 0.9rem;
    }

    .clear-btn {
      background: transparent;
      border: 1px solid #5f5560;
      color: #cbcbcb;
      padding: 0.4rem 1.4rem;
      border-radius: 3rem;
      font-size: 0.7rem;
      font-weight: 600;
      cursor: pointer;
      transition: 0.2s;
      letter-spacing: 0.6px;
    }

    .clear-btn:hover {
      background: #2b1520;
      border-color: #e63946;
      color: white;
    }

    .history-grid {
      display: flex;
      flex-wrap: wrap;
      gap: 0.5rem;
      min-height: 2.8rem;
      align-items: center;
    }

    .chip {
      background: #232136;
      padding: 0.4rem 1.2rem;
      border-radius: 2rem;
      font-weight: 650;
      font-size: 0.85rem;
      color: #fea3a3;
      border: 1px solid #d65a5a40;
      display: flex;
      align-items: center;
      gap: 0.3rem;
    }

    .footer-note {
      text-align: center;
      margin-top: 1.5rem;
      color: #61698a;
      font-size: 0.7rem;
      display: flex;
      justify-content: center;
      gap: 0.5rem;
    }

    @media (max-width: 550px) {
      .rkn-terminal {
        padding: 1.5rem;
      }
      .app-name {
        font-size: 2.5rem;
      }
      h1 {
        font-size: 1.6rem;
      }
      .execution-btn {
        font-size: 1.3rem;
        width: 100%;
      }
    }
    .shake {
      animation: shakeEffect 0.2s ease-in-out;
    }
    @keyframes shakeEffect {
      0% { transform: translateX(0); }
      25% { transform: translateX(-4px); }
      50% { transform: translateX(4px); }
      100% { transform: translateX(0); }
    }
  </style>
</head>
<body>
<div class="rkn-terminal" id="terminal">
  <div class="emblem">
    <div class="double-eagle">
      <i class="fas fa-shield-haltered"></i> РОСКОМНАДЗОР <i class="fas fa-balance-scale"></i>
    </div>
    <div class="department-badge">⚡ ЦИФРОВАЯ ИНКВИЗИЦИЯ ⚡</div>
    <h1>ЧТО МЫ БАНИМ СЕГОДНЯ?</h1>
    <div class="sub-header">
      <span><i class="fas fa-gavel"></i> решение окончательное</span>
      <span><i class="fas fa-skull"></i> обжалованию не подлежит</span>
    </div>
  </div>

  <div class="roulette-stage">
    <div class="wheel-container" id="wheelContainer">
      <div class="target-display">
        <div class="stamp"><i class="fas fa-ban"></i> ПРИГОВОР <i class="fas fa-ban"></i></div>
        <div id="appNameDisplay" class="app-name">DISCORD</div>
        <div class="roulette-slot-machine" id="slotPreview">
          <span class="slot-item">WhatsApp</span>
          <span class="slot-item">YouTube</span>
          <span class="slot-item">Telegram</span>
        </div>
      </div>
      <button id="spinButton" class="execution-btn">
        <i class="fas fa-skull-crossbones"></i> ЗАПРЕТИТЬ <i class="fas fa-skull-crossbones"></i>
      </button>
    </div>
  </div>

  <div class="history-panel">
    <div class="history-header">
      <span><i class="fas fa-scroll"></i> ЖУРНАЛ РЕПРЕССИЙ</span>
      <button id="clearHistoryButton" class="clear-btn"><i class="fas fa-trash-alt"></i> СТЕРЕТЬ</button>
    </div>
    <div id="historyContainer" class="history-grid">
      <span class="chip"><i class="fas fa-circle"></i> пока чисто</span>
    </div>
  </div>
  <div class="footer-note">
    <i class="fas fa-microchip"></i> Алгоритм «ЧЕСТНЫЙ РАНДОМ» v2.0 · все совпадения — злой умысел
  </div>
</div>

<script>
  (function() {
    // Расширенный список сервисов для большей вариативности
    const BAN_TARGETS = [
      "Telegram", "WhatsApp", "Discord", "YouTube", "Instagram", "Facebook",
      "TikTok", "Twitch", "Signal", "Viber", "Spotify", "Zoom",
      "Snapchat", "LinkedIn", "OnlyFans", "Likee", "Pinterest", "Reddit",
      "Twitter (X)", "WeChat", "Threema", "FaceTime", "Google Meet",
      "ВКонтакте", "Одноклассники", "Яндекс.Диск", "МТС Connect",
      "GitHub", "Steam", "Netflix", "SoundCloud", "Duolingo"
    ];

    // DOM элементы
    const appNameDisplay = document.getElementById('appNameDisplay');
    const spinBtn = document.getElementById('spinButton');
    const historyContainer = document.getElementById('historyContainer');
    const clearHistoryBtn = document.getElementById('clearHistoryButton');
    const slotPreview = document.getElementById('slotPreview');
    const wheelContainer = document.getElementById('wheelContainer');

    // История (максимум 12 записей)
    let banHistory = [];
    let isSpinning = false;

    // Загрузка истории
    function loadHistoryFromStorage() {
      try {
        const stored = localStorage.getItem('rkn_roulette_v2_history');
        if (stored) {
          const parsed = JSON.parse(stored);
          if (Array.isArray(parsed)) {
            banHistory = parsed.filter(item => typeof item === 'string' && item.length > 0).slice(0, 12);
          }
        }
      } catch (e) {}
      if (banHistory.length === 0) {
        // начальные демо-записи для атмосферы
        banHistory = ["Discord", "Telegram"];
      }
      renderHistory();
    }

    function saveHistoryToStorage() {
      localStorage.setItem('rkn_roulette_v2_history', JSON.stringify(banHistory.slice(0, 12)));
    }

    // Рендер истории
    function renderHistory() {
      historyContainer.innerHTML = '';
      if (!banHistory.length) {
        const emptyMsg = document.createElement('span');
        emptyMsg.className = 'chip';
        emptyMsg.innerHTML = '<i class="fas fa-circle"></i> пока никого';
        historyContainer.appendChild(emptyMsg);
        return;
      }

      banHistory.forEach(app => {
        const chip = document.createElement('span');
        chip.className = 'chip';
        chip.innerHTML = `<i class="fas fa-skull" style="font-size:0.7rem;"></i> ${app}`;
        historyContainer.appendChild(chip);
      });
    }

    // Добавление в историю
    function addToHistory(app) {
      banHistory.unshift(app);
      if (banHistory.length > 12) banHistory.pop();
      saveHistoryToStorage();
      renderHistory();
    }

    // Очистка истории
    function clearHistory() {
      banHistory = [];
      saveHistoryToStorage();
      renderHistory();
      // микро-анимация подтверждения
      historyContainer.style.transform = 'scale(0.96)';
      setTimeout(() => { historyContainer.style.transform = ''; }, 150);
    }

    // Случайный элемент из массива
    function getRandomTarget() {
      return BAN_TARGETS[Math.floor(Math.random() * BAN_TARGETS.length)];
    }

    // Обновление мини-слотов (превью)
    function updateSlotPreview(appsArray) {
      slotPreview.innerHTML = '';
      appsArray.forEach(app => {
        const span = document.createElement('span');
        span.className = 'slot-item';
        span.textContent = app;
        slotPreview.appendChild(span);
      });
    }

    // Основная функция спина с эффектом прокрутки
    function executeSpin() {
      if (isSpinning) return;
      isSpinning = true;
      spinBtn.disabled = true;
      spinBtn.innerHTML = '<i class="fas fa-spinner fa-pulse"></i> ВЫНОСИМ ПРИГОВОР...';

      // Добавим вибрацию на контейнер
      wheelContainer.classList.add('shake');
      setTimeout(() => wheelContainer.classList.remove('shake'), 200);

      // Имитация рулетки: быстро меняем названия
      let cycles = 0;
      const maxCycles = 14; // количество смен до остановки
      const intervalTime = 55; // мс

      const rollInterval = setInterval(() => {
        // случайные три приложения для превью
        const previewApps = [getRandomTarget(), getRandomTarget(), getRandomTarget()];
        updateSlotPreview(previewApps);
        
        // меняем главное название
        appNameDisplay.textContent = getRandomTarget();
        appNameDisplay.style.opacity = '0.65';
        setTimeout(() => { if (appNameDisplay) appNameDisplay.style.opacity = '1'; }, 30);

        cycles++;
        if (cycles >= maxCycles) {
          clearInterval(rollInterval);
          // Финальный результат
          const finalApp = getRandomTarget();
          appNameDisplay.textContent = finalApp;
          appNameDisplay.style.opacity = '1';
          
          // Финальное превью
          updateSlotPreview([finalApp, getRandomTarget(), getRandomTarget()]);
          
          // Добавляем в историю
          addToHistory(finalApp);
          
          // Эффект завершения
          wheelContainer.style.transition = '0.15s';
          wheelContainer.style.transform = 'scale(1.02)';
          setTimeout(() => {
            wheelContainer.style.transform = '';
          }, 120);
          
          // Звуковая имитация через вибрацию (визуально)
          document.body.style.transform = 'translateX(2px)';
          setTimeout(() => { document.body.style.transform = ''; }, 70);
          
          // Восстановление кнопки
          spinBtn.disabled = false;
          spinBtn.innerHTML = '<i class="fas fa-skull-crossbones"></i> ЗАПРЕТИТЬ <i class="fas fa-skull-crossbones"></i>';
          isSpinning = false;
        }
      }, intervalTime);
    }

    // Установка случайного приложения при загрузке
    function setRandomInitialApp() {
      const randomApp = getRandomTarget();
      appNameDisplay.textContent = randomApp;
      updateSlotPreview([randomApp, getRandomTarget(), getRandomTarget()]);
    }

    // Обработчики событий
    spinBtn.addEventListener('click', executeSpin);

    clearHistoryBtn.addEventListener('click', clearHistory);

    // Инициализация
    loadHistoryFromStorage();
    setRandomInitialApp();

    // Дополнительный эффект: при наведении на кнопку (не активно)
    spinBtn.addEventListener('mouseenter', () => {
      if (!spinBtn.disabled) {
        spinBtn.style.filter = 'brightness(1.15) drop-shadow(0 0 8px #ff4d4d)';
      }
    });
    spinBtn.addEventListener('mouseleave', () => {
      spinBtn.style.filter = '';
    });

    // Обработка touch для мобильных
    spinBtn.addEventListener('touchstart', (e) => {
      if (!spinBtn.disabled) {
        spinBtn.style.filter = 'brightness(1.1)';
      }
    }, {passive: true});
    spinBtn.addEventListener('touchend', () => {
      spinBtn.style.filter = '';
    });

  })();
</script>
</body>
</html>
