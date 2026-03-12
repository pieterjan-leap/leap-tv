const https = require('https');

const API_KEY  = '063488be-f117-4598-91cb-f497c07c9f0f';
const API_BASE = 'api.sugarwod.com';

exports.handler = async (event) => {
  const path = event.queryStringParameters?.path;

  if (!path) {
    return { statusCode: 400, body: JSON.stringify({ error: 'Missing path parameter' }) };
  }

  // Alleen /v2/ routes toestaan
  if (!path.startsWith('/v2/')) {
    return { statusCode: 403, body: JSON.stringify({ error: 'Forbidden path' }) };
  }

  try {
    const data = await fetchSugarWOD(path);
    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
      body: JSON.stringify(data),
    };
  } catch (e) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: e.message }),
    };
  }
};

function fetchSugarWOD(path) {
  return new Promise((resolve, reject) => {
    const options = {
      hostname: API_BASE,
      path: path,
      method: 'GET',
      headers: { 'Authorization': API_KEY },
    };

    const req = https.request(options, (res) => {
      let body = '';
      res.on('data', chunk => body += chunk);
      res.on('end', () => {
        try { resolve(JSON.parse(body)); }
        catch (e) { reject(new Error('Invalid JSON response')); }
      });
    });

    req.on('error', reject);
    req.end();
  });
}
