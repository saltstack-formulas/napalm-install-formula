# Installs NAPALM packages and system dependencies
{% from "napalm_install/map.jinja" import map with context %}

{%- set napalm_libs = salt.pillar.get('napalm:install', []) -%}

{%- if 'napalm' in napalm_libs -%}
# Install the whole lib
install_napalm_pkgs:
  pkg.installed:
    - pkgs:
      {%- for driver, driver_pkgs in map.iteritems() -%}
        {% for pkg in driver_pkgs %}
      - {{ pkg }}
        {% endfor %}
      {% endfor %}
napalm:
  pip.installed
{%- else -%}
# install invididual packages
{%- set install_drivers = {'list': []} -%}
{%- for lib in napalm_libs -%}
  {%- set driver = lib | replace('napalm-', '') | replace('napalm_', '') -%}
  {%- do install_drivers['list'].append(driver) -%}
{%- endfor -%}
{%- for driver in install_drivers['list'] -%}
  {%- if driver in map %}
install_napalm_{{ driver }}_pkgs:
  pkg.installed:
    - pkgs:
      {% for pkg in map[driver] %}
      - {{ pkg }}
      {%- endfor -%}
  {%- endif %}
napalm-{{ driver }}:
  pip.installed
{%- endfor -%}
{%- endif -%}
