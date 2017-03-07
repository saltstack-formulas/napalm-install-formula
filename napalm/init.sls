# Installs NAPALM packages and system dependencies
{% from "napalm/map.jinja" import map with context %}

{%- set napalm_libs = salt.pillar.get('napalm_libraries', []) -%}

{%- if 'napalm' in packages -%}
# Install the whole lib
install_napalm_pkgs:
  pkg.installed:
    - pkgs:
      {%- for driver, driver_pkgs in map.iteritems() -%}
        {%- for pkg in driver_pkgs -%}
      - {{ pkg }}
        {% endfor %}
      {% endfor %}
{%- else -%}
# install invididual packages
{%- set install_drivers = {'list': []} -%}
{%- for lib in napalm_libs -%}
  {%- set driver = lib | replace('napalm-', '') | replace('napalm_', '') -%}
  {%- do install_drivers['list'].append(driver) -%}
{%- endfor -%}
{%- for driver in install_drivers['list'] -%}
  {%- if driver in map -%}
install_packages_for_{{ driver }}:
  pkg.installed:
    - pkgs:
      {%- for pkg in map[driver] -%}
      - {{ pkg }}
      {%- endfor -%}
  {%- endif -%}
{%- endfor -%}
{%- endif -%}
