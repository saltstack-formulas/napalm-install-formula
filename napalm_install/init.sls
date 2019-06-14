# Installs NAPALM packages and system dependencies
{% from "napalm_install/map.jinja" import pkgs with context %}

Install system packages:
  pkg.installed:
    - pkgs:
      {%- for pkg in pkgs %}
      - {{ pkg }}
      {%- endfor %}

Install NAPALM:
  pip.installed:
    - name: napalm{%- if pillar.napalm.get('version') %}=={{ pillar.napalm.version }}{%- endif %}
    - upgrade: {{ pillar.napalm.get('upgrade', false) }}
    - require:
      - pkg: Install system packages

{%- if pillar.napalm.get('additional_drivers') %}
Install additional drivers:
  pip.installed:
    - pkgs:
      {%- for pkg in pillar.napalm.additional_drivers %}
      - {{ pkg }}
      {%- endfor %}
    - upgrade: {{ pillar.napalm.get('upgrade', false) }}
    - require:
      - pip: Install NAPALM
{%- endif %}
