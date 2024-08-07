base:
  '*':
    - prom

  'role:web':
    - match: grain
    - nginx

  'role:mgmt':
    - match: grain
    - mgmt