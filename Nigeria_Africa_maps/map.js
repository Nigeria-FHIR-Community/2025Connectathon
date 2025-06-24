// Main variables
let currentView = 'nigeria'; // Track current view: 'nigeria', 'state', 'lga'
let currentState = null; // Track current state when in state view
let currentLGA = null; // Track current LGA when in LGA view
let svg, g, zoom; // D3 elements
let width, height; // Dimensions
let tooltip = d3.select('#tooltip');
let systemModal = document.getElementById('systemModal');
let closeModalBtn = document.querySelector('.close');
let loadingElement = document.getElementById('loading');

// Dummy data for energy systems
const energySystemData = {
    nigeria: {
        statesWithSystems: [
            'FCT', 'Lagos', 'Kano', 'Rivers', 'Kaduna', 'Enugu', 'Oyo', 'Delta', 'Ekiti', 'Yobe', 'Kebbi'
        ],
        beams: [
            { id: 'FCT-beam-1', state: 'FCT', lat: 9.0765, lng: 7.3986, active: true },
            { id: 'FCT-beam-2', state: 'FCT', lat: 9.1765, lng: 7.4986, active: false },
            { id: 'Lagos-beam-1', state: 'Lagos', lat: 6.5244, lng: 3.3792, active: true },
            { id: 'Kano-beam-1', state: 'Kano', lat: 12.0022, lng: 8.5917, active: true },
            { id: 'Rivers-beam-1', state: 'Rivers', lat: 4.8156, lng: 7.0498, active: false },
            { id: 'Kaduna-beam-1', state: 'Kaduna', lat: 10.5260, lng: 7.4379, active: true },
            { id: 'Enugu-beam-1', state: 'Enugu', lat: 6.4584, lng: 7.5464, active: false },
            { id: 'Oyo-beam-1', state: 'Oyo', lat: 7.3775, lng: 3.9470, active: true },
            { id: 'Delta-beam-1', state: 'Delta', lat: 5.5322, lng: 5.8987, active: false },
            { id: 'Ekiti-beam-1', state: 'Ekiti', lat: 7.7319, lng: 5.3111, active: true },
            { id: 'Ekiti-beam-2', state: 'Ekiti', lat: 7.6319, lng: 5.4111, active: false },
            { id: 'Yobe-beam-1', state: 'Yobe', lat: 12.2890, lng: 11.9661, active: true },
            { id: 'Yobe-beam-2', state: 'Yobe', lat: 12.1890, lng: 12.0661, active: false },
            { id: 'Kebbi-beam-1', state: 'Kebbi', lat: 12.4532, lng: 4.1975, active: true },
            { id: 'Kebbi-beam-2', state: 'Kebbi', lat: 12.5532, lng: 4.2975, active: false }
        ]
    },
    states: {
        'FCT': {
            lgasWithSystems: ['AMAC', 'Bwari', 'Gwagwalada'],
            beams: [
                { id: 'AMAC-beam-1', lga: 'AMAC', lat: 9.0565, lng: 7.4986, active: true, details: {
                    name: "AMAC Solar System 1",
                    capacity: "50kW",
                    installation_date: "2023-05-15",
                    last_maintenance: "2024-02-20",
                    status: "active",
                    battery_level: "85%",
                    daily_output: "42kWh",
                    beneficiaries: "250 households"
                }},
                { id: 'AMAC-beam-2', lga: 'AMAC', lat: 9.0665, lng: 7.5086, active: true, details: {
                    name: "AMAC Solar System 2",
                    capacity: "35kW",
                    installation_date: "2023-08-10",
                    last_maintenance: "2024-03-15",
                    status: "active",
                    battery_level: "92%",
                    daily_output: "31kWh",
                    beneficiaries: "180 households"
                }},
                { id: 'AMAC-beam-3', lga: 'AMAC', lat: 9.0765, lng: 7.5186, active: false, details: {
                    name: "AMAC Solar System 3",
                    capacity: "40kW",
                    installation_date: "2023-10-05",
                    last_maintenance: "2024-01-10",
                    status: "inactive",
                    battery_level: "0%",
                    daily_output: "0kWh",
                    beneficiaries: "200 households",
                    issue: "Inverter failure, replacement scheduled for next week"
                }},
                { id: 'AMAC-beam-4', lga: 'AMAC', lat: 9.0865, lng: 7.5286, active: false, details: {
                    name: "AMAC Solar System 4",
                    capacity: "25kW",
                    installation_date: "2023-12-15",
                    last_maintenance: "2024-04-05",
                    status: "inactive",
                    battery_level: "15%",
                    daily_output: "0kWh",
                    beneficiaries: "120 households",
                    issue: "Battery degradation, maintenance team dispatched"
                }},
                { id: 'Bwari-beam-1', lga: 'Bwari', lat: 9.2765, lng: 7.3986, active: true, details: {
                    name: "Bwari Solar System 1",
                    capacity: "60kW",
                    installation_date: "2023-06-20",
                    last_maintenance: "2024-03-05",
                    status: "active",
                    battery_level: "78%",
                    daily_output: "53kWh",
                    beneficiaries: "310 households"
                }},
                { id: 'Bwari-beam-2', lga: 'Bwari', lat: 9.2865, lng: 7.4086, active: false, details: {
                    name: "Bwari Solar System 2",
                    capacity: "45kW",
                    installation_date: "2023-09-12",
                    last_maintenance: "2024-02-28",
                    status: "inactive",
                    battery_level: "5%",
                    daily_output: "0kWh",
                    beneficiaries: "230 households",
                    issue: "Control system failure, technicians scheduled"
                }},
                { id: 'Gwagwalada-beam-1', lga: 'Gwagwalada', lat: 8.9465, lng: 7.0886, active: true, details: {
                    name: "Gwagwalada Solar System 1",
                    capacity: "55kW",
                    installation_date: "2023-07-25",
                    last_maintenance: "2024-04-10",
                    status: "active",
                    battery_level: "90%",
                    daily_output: "48kWh",
                    beneficiaries: "275 households"
                }}
            ]
        },
        'Lagos': {
            lgasWithSystems: ['Eti-Osa', 'Ikeja', 'Surulere'],
            beams: [
                { id: 'Eti-Osa-beam-1', lga: 'Eti-Osa', lat: 6.4565, lng: 3.5486, active: true, details: {
                    name: "Eti-Osa Solar System 1",
                    capacity: "70kW",
                    installation_date: "2023-04-18",
                    last_maintenance: "2024-01-15",
                    status: "active",
                    battery_level: "82%",
                    daily_output: "65kWh",
                    beneficiaries: "350 households"
                }},
                { id: 'Ikeja-beam-1', lga: 'Ikeja', lat: 6.6065, lng: 3.3486, active: true, details: {
                    name: "Ikeja Solar System 1",
                    capacity: "65kW",
                    installation_date: "2023-05-30",
                    last_maintenance: "2024-02-15",
                    status: "active",
                    battery_level: "88%",
                    daily_output: "60kWh",
                    beneficiaries: "320 households"
                }},
                { id: 'Surulere-beam-1', lga: 'Surulere', lat: 6.5065, lng: 3.3786, active: false, details: {
                    name: "Surulere Solar System 1",
                    capacity: "50kW",
                    installation_date: "2023-08-15",
                    last_maintenance: "2024-03-20",
                    status: "inactive",
                    battery_level: "10%",
                    daily_output: "0kWh",
                    beneficiaries: "240 households",
                    issue: "Solar panel damage, replacement in progress"
                }}
            ]
        },
        'Ekiti': {
            lgasWithSystems: ['Ado-Ekiti', 'Ikere', 'Oye'],
            beams: [
                { id: 'Ado-Ekiti-beam-1', lga: 'Ado-Ekiti', lat: 7.6319, lng: 5.2311, active: true, details: {
                    name: "Ado-Ekiti Solar System 1",
                    capacity: "45kW",
                    installation_date: "2023-06-10",
                    last_maintenance: "2024-02-25",
                    status: "active",
                    battery_level: "79%",
                    daily_output: "38kWh",
                    beneficiaries: "220 households"
                }},
                { id: 'Ikere-beam-1', lga: 'Ikere', lat: 7.5019, lng: 5.2311, active: false, details: {
                    name: "Ikere Solar System 1",
                    capacity: "30kW",
                    installation_date: "2023-08-05",
                    last_maintenance: "2024-01-20",
                    status: "inactive",
                    battery_level: "12%",
                    daily_output: "0kWh",
                    beneficiaries: "160 households",
                    issue: "Weather damage, repair in progress"
                }}
            ]
        },
        'Yobe': {
            lgasWithSystems: ['Damaturu', 'Potiskum', 'Gashua'],
            beams: [
                { id: 'Damaturu-beam-1', lga: 'Damaturu', lat: 11.7467, lng: 11.9608, active: true, details: {
                    name: "Damaturu Solar System 1",
                    capacity: "55kW",
                    installation_date: "2023-07-15",
                    last_maintenance: "2024-03-10",
                    status: "active",
                    battery_level: "86%",
                    daily_output: "47kWh",
                    beneficiaries: "280 households"
                }},
                { id: 'Potiskum-beam-1', lga: 'Potiskum', lat: 11.7097, lng: 11.0808, active: true, details: {
                    name: "Potiskum Solar System 1",
                    capacity: "40kW",
                    installation_date: "2023-09-20",
                    last_maintenance: "2024-02-15",
                    status: "active",
                    battery_level: "91%",
                    daily_output: "35kWh",
                    beneficiaries: "200 households"
                }}
            ]
        },
        'Kebbi': {
            lgasWithSystems: ['Birnin Kebbi', 'Argungu', 'Yauri'],
            beams: [
                { id: 'Birnin-Kebbi-beam-1', lga: 'Birnin Kebbi', lat: 12.4532, lng: 4.1975, active: true, details: {
                    name: "Birnin Kebbi Solar System 1",
                    capacity: "50kW",
                    installation_date: "2023-05-25",
                    last_maintenance: "2024-01-30",
                    status: "active",
                    battery_level: "83%",
                    daily_output: "43kWh",
                    beneficiaries: "260 households"
                }},
                { id: 'Argungu-beam-1', lga: 'Argungu', lat: 12.7440, lng: 4.5219, active: false, details: {
                    name: "Argungu Solar System 1",
                    capacity: "35kW",
                    installation_date: "2023-10-12",
                    last_maintenance: "2024-03-05",
                    status: "inactive",
                    battery_level: "8%",
                    daily_output: "0kWh",
                    beneficiaries: "180 households",
                    issue: "Sand storm damage, cleaning and repair scheduled"
                }}
            ]
        }
    }
};

// Initialize map on page load
document.addEventListener('DOMContentLoaded', function() {
    initializeMap();
    setupEventListeners();
    
    setTimeout(function() {
        loadingElement.style.display = 'none';
    }, 1500);
    
    updateSystemStats();
});

function initializeMap() {
    const mapWrapper = document.getElementById('map-wrapper');
    width = mapWrapper.clientWidth;
    height = mapWrapper.clientHeight;
    
    svg = d3.select('#map-wrapper')
        .append("svg")
        .attr("class", "map")
        .attr("width", width)
        .attr("height", height);
    
    zoom = d3.zoom()
        .scaleExtent([1, 8])
        .on("zoom", function(event) {
            g.attr("transform", event.transform);
        });
    
    svg.call(zoom);
    
    g = svg.append("g");
    
    loadNigeriaMap();
}

function resetZoom() {
    svg.transition().duration(750).call(
        zoom.transform,
        d3.zoomIdentity.translate(0, 0).scale(1)
    );
}

function loadMap(view, stateName = null, lgaName = null) {
    loadingElement.style.display = 'flex';
    
    g.selectAll("*").remove();
    
    if (view === 'nigeria') {
        loadNigeriaMap();
        currentView = 'nigeria';
        currentState = null;
        currentLGA = null;
        updateBreadcrumb();
        updateTitle("Nigeria Energy Systems Map");
    } else if (view === 'state' && stateName) {
        loadStateMap(stateName);
        currentView = 'state';
        currentState = stateName;
        currentLGA = null;
        updateBreadcrumb();
        updateTitle(`${stateName} Energy Systems Map`);
    }
    
    updateSystemStats();
    
    setTimeout(function() {
        loadingElement.style.display = 'none';
    }, 800);
}

function loadNigeriaMap() {
    const embeddedMap = document.querySelector('#nigeria-map svg');
    if (!embeddedMap) {
        console.error('Nigeria SVG map not found.');
        return;
    }

    g.selectAll("*").remove();

    const clonedMap = embeddedMap.cloneNode(true);
    g.node().appendChild(clonedMap);

    document.getElementById("map-title").textContent = "Nigeria Energy Systems Map";
    updateBreadcrumb();

    const stateNameToSvgId = {
        'fct': 'abuja',
        'lagos': 'lagos',
        'kano': 'kano',
        'rivers': 'rivers',
        'kaduna': 'kaduna',
        'enugu': 'enugu',
        'oyo': 'oyo',
        'delta': 'delta',
        'ekiti': 'ekiti',
        'yobe': 'yobe',
        'kebbi': 'kebbi',
        'adamawa': 'adamawa',
        'ebonyi': 'ebonyi',
        'niger': 'niger',
        
        
        
    };

    const statesWithSystems = energySystemData.nigeria.statesWithSystems
        .map(s => stateNameToSvgId[s.toLowerCase()] || s.toLowerCase());

    d3.select(clonedMap)
        .selectAll('path')
        .each(function() {
            const state = d3.select(this);
            const stateId = state.attr("id")?.toLowerCase();

            if (!stateId) return;

            const hasSystem = statesWithSystems.includes(stateId);

            state
                .attr("class", "state " + (hasSystem ? "with-energy" : "no-energy"))
                .style("cursor", "pointer")
                .style("fill", hasSystem ? "#4CAF50" : "#cccccc")
                .on("mouseover", function(event) {
                    const hoverColor = hasSystem ? "#66BB6A" : "#e0e0e0";
                    d3.select(this).style("fill", hoverColor);
                    showTooltip(event, stateId.toUpperCase());
                })
                .on("mouseout", function() {
                    const originalColor = hasSystem ? "#4CAF50" : "#cccccc";
                    d3.select(this).style("fill", originalColor);
                    hideTooltip();
                })
                .on("click", function() {
                    loadStateMap(stateId);
                });
        });

    addBeamsToMap(energySystemData.nigeria.beams, 'state');
    
    const mapBounds = g.node().getBBox();
    const scale = Math.min(width / mapBounds.width, height / mapBounds.height) * 0.8;
    const translateX = (width - mapBounds.width * scale) / 2;
    const translateY = (height - mapBounds.height * scale) / 2;
    g.attr("transform", `translate(${translateX}, ${translateY}) scale(${scale})`);
}

function loadStateMap(stateId) {
    loadingElement.style.display = 'flex';
    
    g.selectAll("*").remove();
    
    const stateName = stateId.toUpperCase();
    
    const stateToMapId = {
        'fct': 'Abuja-map',
        'abuja': 'Abuja-map',
        'lagos': 'Lagos-map',
        'adamawa': 'Adamawa-map',
        'ekiti': 'Ekiti-map',
        'kano': 'kano-map',
        'rivers': 'Rivers-map',
        'kaduna': 'kaduna-map',
        'enugu': 'Enugu-map',
        'oyo': 'Oyo-map',
        'delta': 'Delta-map',
        'yobe': 'Yobe-map',
        'kebbi': 'Kebbi-map',
        'ebonyi': 'Ebonyi-map',
        'niger': 'Niger-map'
        
    };

    const mapElementId = stateToMapId[stateId.toLowerCase()] || `${stateId.toLowerCase()}-map`;
    const svgElement = document.querySelector(`#${mapElementId} svg`);
    
    if (!svgElement) {
        console.error(`SVG for ${stateName} not found`);
        createPlaceholderStateMap(stateName);
        return;
    }

    const clonedMap = svgElement.cloneNode(true);
    g.node().appendChild(clonedMap);

    const stateData = energySystemData.states[stateName] || { lgasWithSystems: [], beams: [] };
    const lgasWithSystems = stateData.lgasWithSystems || [];

    const lgaNameToSvgId = {
        'AMAC': 'AMAC',
        'Bwari': 'Bwari',
        'Gwagwalada': 'Gwagwalada',
        'Kwali': 'Kwali',
        'Abaji': 'Abaji',
        'Kuje': 'Kuje',
        'Eti-Osa': 'Eti-Osa',
        'Ikeja': 'Ikeja',
        'Surulere': 'Surulere',
        'Lagos Island': 'Lagos-Island',
        'Lagos Mainland': 'Lagos-Mainland',
        'Ado-Ekiti': 'Ado-Ekiti',
        'Ikere': 'Ikere',
        'Oye': 'Oye',
        'Damaturu': 'Damaturu',
        'Potiskum': 'Potiskum',
        'Gashua': 'Gashua',
        'Birnin Kebbi': 'Birnin-Kebbi',
        'Argungu': 'Argungu',
        'Yauri': 'Yauri'
    };

    // Log for debugging
    console.log(`Loading state map for ${stateName}`);
    console.log('LGAs with systems:', lgasWithSystems);
    console.log('Available SVG IDs:', Array.from(d3.select(clonedMap).selectAll('path').nodes()).map(node => node.getAttribute('id')));

    // Apply styling and interactions to all LGAs
    d3.select(clonedMap)
        .selectAll('path')
        .each(function() {
            const lga = d3.select(this);
            const lgaId = lga.attr("id");
            if (!lgaId) {
                console.warn('LGA path missing ID');
                return;
            }

            // Find the original LGA name from the SVG ID
            const originalLgaName = Object.keys(lgaNameToSvgId).find(key => lgaNameToSvgId[key] === lgaId) || lgaId;
            const hasSystem = lgasWithSystems.includes(originalLgaName);

            console.log(`LGA ${lgaId} (original: ${originalLgaName}) has system: ${hasSystem}`);

            lga
                .attr("class", `lga ${hasSystem ? "with-energy" : "no-energy"}`)
                .style("cursor", "pointer")
                .style("stroke", "#ffffff")
                .style("stroke-width", "2px")
                .style("fill", hasSystem ? "#4CAF50" : "#cccccc")
                .on("mouseover", function(event) {
                    const hoverColor = hasSystem ? "#66BB6A" : "#e0e0e0";
                    d3.select(this).style("fill", hoverColor);
                    showTooltip(event, originalLgaName);
                })
                .on("mouseout", function() {
                    const originalColor = hasSystem ? "#4CAF50" : "#cccccc";
                    d3.select(this).style("fill", originalColor);
                    hideTooltip();
                })
                .on("click", function() {
                    alert(`Clicked on LGA: ${originalLgaName}`);
                });
        });

    // Add beams after LGA styling to ensure they're on top
    if (stateData.beams) {
        console.log(`Adding ${stateData.beams.length} beams for ${stateName}`);
        addBeamsToMap(stateData.beams, 'lga');
    }

    currentView = 'state';
    currentState = stateName;
    currentLGA = null;
    updateBreadcrumb();
    updateTitle(`${stateName} Energy Systems Map`);
    
    const mapBounds = g.node().getBBox();
    const scale = Math.min(width / mapBounds.width, height / mapBounds.height) * 0.8;
    const translateX = (width - mapBounds.width * scale) / 2;
    const translateY = (height - mapBounds.height * scale) / 2;
    g.attr("transform", `translate(${translateX}, ${translateY}) scale(${scale})`);
    
    updateSystemStats();
    
    setTimeout(function() {
        loadingElement.style.display = 'none';
    }, 800);
}

function createPlaceholderStateMap(stateName) {
    console.log(`Creating placeholder map for ${stateName}`);
    
    g.append("rect")
        .attr("x", 100)
        .attr("y", 100)
        .attr("width", 300)
        .attr("height", 300)
        .attr("fill", "#f0f0f0")
        .attr("stroke", "#cccccc")
        .attr("stroke-width", 2);
        
    g.append("text")
        .attr("x", 250)
        .attr("y", 250)
        .attr("text-anchor", "middle")
        .attr("font-size", 24)
        .attr("font-weight", "bold")
        .attr("fill", "#999999")
        .text(`${stateName} Map`);
        
    g.append("text")
        .attr("x", 250)
        .attr("y", 280)
        .attr("text-anchor", "middle")
        .attr("font-size", 16)
        .attr("fill", "#999999")
        .text("(Map data not available)");
        
    const stateData = energySystemData.states[stateName] || { lgasWithSystems: [], beams: [] };
    const lgasWithSystems = stateData.lgasWithSystems || [];
    
    if (lgasWithSystems.length > 0) {
        lgasWithSystems.forEach((lga, index) => {
            const x = 150 + (index % 2) * 100;
            const y = 150 + Math.floor(index / 2) * 70;
            
            g.append("circle")
                .attr("cx", x)
                .attr("cy", y)
                .attr("r", 30)
                .attr("class", "lga with-energy")
                .style("fill", "#4CAF50")
                .on("mouseover", function(event) {
                    showTooltip(event, lga);
                })
                .on("mouseout", function() {
                    hideTooltip();
                })
                .on("click", function() {
                    alert(`Clicked on LGA: ${lga}`);
                });
                
            g.append("text")
                .attr("x", x)
                .attr("y", y)
                .attr("text-anchor", "middle")
                .attr("dominant-baseline", "middle")
                .attr("font-size", 10)
                .attr("fill", "#ffffff")
                .text(lga);
        });
    }
    
    if (stateData.beams) {
        addBeamsToMap(stateData.beams, 'lga');
    }
}

function addBeamsToMap(beams, level) {
    if (!beams || beams.length === 0) return;
    
    const beamRadius = 8;
    const pulseRadius = 12;
    
    const mapBounds = g.node().getBBox();
    
    beams.forEach((beam, index) => {
        let x, y;
        
        if (level === 'state') {
            const nigeriaBounds = {
                north: 14.0,
                south: 4.0,
                west: 2.5,
                east: 15.0
            };
            
            const xRatio = (beam.lng - nigeriaBounds.west) / (nigeriaBounds.east - nigeriaBounds.west);
            const yRatio = (nigeriaBounds.north - beam.lat) / (nigeriaBounds.north - nigeriaBounds.south);
            
            x = mapBounds.x + (xRatio * mapBounds.width);
            y = mapBounds.y + (yRatio * mapBounds.height);
        } else if (level === 'lga') {
            const lgaPositions = getLGAPosition(beam.lga, currentState);
            
            if (lgaPositions) {
                // Adjust beam positions to avoid overlap within the same LGA
                const beamsInSameLGA = beams.filter(b => b.lga === beam.lga);
                const beamIndex = beamsInSameLGA.findIndex(b => b.id === beam.id);
                const offset = beamIndex * 20; // Offset each beam by 20 pixels
                
                x = mapBounds.x + (lgaPositions.x * mapBounds.width) + offset - (beamsInSameLGA.length * 10);
                y = mapBounds.y + (lgaPositions.y * mapBounds.height);
            } else {
                // Fallback to distributed positioning
                x = mapBounds.x + (index % 3) * (mapBounds.width / 3) + (mapBounds.width / 6);
                y = mapBounds.y + Math.floor(index / 3) * (mapBounds.height / 3) + (mapBounds.height / 6);
            }
        }
        
        if (isNaN(x) || isNaN(y)) {
            console.warn(`Invalid coordinates for beam ${beam.id}`);
            return;
        }
        
        console.log(`Adding beam ${beam.id} at (${x}, ${y}) for ${beam.lga}`);
        
        const beamGroup = g.append("g")
            .attr("class", `beam-group`)
            .attr("transform", `translate(${x}, ${y})`);
            
        const pulse = beamGroup.append("circle")
            .attr("class", "beam-pulse")
            .attr("r", pulseRadius)
            .attr("fill", beam.active ? "rgba(33, 150, 243, 0.3)" : "rgba(244, 67, 54, 0.3)")
            .attr("opacity", 0.7);
            
        pulse.transition()
            .duration(2000)
            .attr("r", beamRadius)
            .attr("opacity", 0.3)
            .transition()
            .duration(2000)
            .attr("r", pulseRadius)
            .attr("opacity", 0.7)
            .on("end", function repeat() {
                d3.select(this)
                    .transition()
                    .duration(2000)
                    .attr("r", beamRadius)
                    .attr("opacity", 0.3)
                    .transition()
                    .duration(2000)
                    .attr("r", pulseRadius)
                    .attr("opacity", 0.7)
                    .on("end", repeat);
            });
        
        const beamElement = beamGroup.append("circle")
            .attr("class", `beam beam-${level} ${beam.active ? "active" : "inactive"}`)
            .attr("r", beamRadius)
            .attr("fill", beam.active ? "#2196F3" : "#F44336")
            .attr("stroke", "#ffffff")
            .attr("stroke-width", 2);
            
        if (level === 'lga') {
            beamElement
                .style("cursor", "pointer")
                .on("mouseover", function(event) {
                    const name = beam.details ? beam.details.name : `Energy System in ${beam.lga}`;
                    const status = beam.active ? "Active" : "Inactive";
                    showTooltip(event, `${name} (${status})`);
                })
                .on("mouseout", function() {
                    hideTooltip();
                })
                .on("click", function() {
                    showSystemDetails(beam);
                });
        } else if (level === 'state') {
            beamElement
                .style("cursor", "auto")
                .on("mouseover", function(event) {
                    const status = beam.active ? "Active" : "Inactive";
                    showTooltip(event, `Energy System in ${beam.state} (${status})`);
                })
                .on("mouseout", function() {
                    hideTooltip();
                });
        }
    });
}

function getLGAPosition(lgaName, stateName) {
    const lgaPositions = {
        'FCT': {
            'AMAC': { x: 0.5, y: 0.4 },
            'Bwari': { x: 0.3, y: 0.2 },
            'Gwagwalada': { x: 0.7, y: 0.8 },
            'Kwali': { x: 0.2, y: 0.7 },
            'Kuje': { x: 0.8, y: 0.6 },
            'Abaji': { x: 0.6, y: 0.9 }
        },
        'LAGOS': {
            'Eti-Osa': { x: 0.8, y: 0.6 },
            'Ikeja': { x: 0.4, y: 0.4 },
            'Surulere': { x: 0.6, y: 0.5 },
            'Lagos Island': { x: 0.7, y: 0.8 },
            'Lagos Mainland': { x: 0.5, y: 0.7 }
        },
        'EKITI': {
            'Ado-Ekiti': { x: 0.5, y: 0.4 },
            'Ikere': { x: 0.3, y: 0.7 },
            'Oye': { x: 0.7, y: 0.3 }
        },
        'YOBE': {
            'Damaturu': { x: 0.5, y: 0.4 },
            'Potiskum': { x: 0.3, y: 0.7 },
            'Gashua': { x: 0.7, y: 0.3 }
        },
        'KEBBI': {
            'Birnin Kebbi': { x: 0.5, y: 0.4 },
            'Argungu': { x: 0.3, y: 0.7 },
            'Yauri': { x: 0.7, y: 0.3 }
        }
    };
    
    const statePositions = lgaPositions[stateName.toUpperCase()];
    return statePositions ? statePositions[lgaName] : null;
}

function showTooltip(event, content) {
    tooltip
        .style("left", (event.pageX + 10) + "px")
        .style("top", (event.pageY + 10) + "px")
        .style("display", "block")
        .html(content);
}

function hideTooltip() {
    tooltip.style("display", "none");
}

function showSystemDetails(beam) {
    const details = beam.details;
    if (!details) return;
    
    const statusClass = beam.active ? "status-active" : "status-inactive";
    const statusText = beam.active ? "Active" : "Inactive";
    
    let detailsHTML = `
        <h3>${details.name}</h3>
        <p><strong>Status:</strong> <span class="status-badge ${statusClass}">${statusText}</span></p>
        <table>
            <tr><th>Capacity</th><td>${details.capacity}</td></tr>
            <tr><th>Installation Date</th><td>${details.installation_date}</td></tr>
            <tr><th>Last Maintenance</th><td>${details.last_maintenance}</td></tr>
            <tr><th>Battery Level</th><td>${details.battery_level}</td></tr>
            <tr><th>Daily Output</th><td>${details.daily_output}</td></tr>
            <tr><th>Beneficiaries</th><td>${details.beneficiaries}</td></tr>
    `;
    
    if (!beam.active && details.issue) {
        detailsHTML += `<tr><th>Issue</th><td>${details.issue}</td></tr>`;
    }
    
    detailsHTML += `</table>`;
    
    document.getElementById('system-details').innerHTML = detailsHTML;
    systemModal.style.display = "block";
}

function updateBreadcrumb() {
    const breadcrumb = document.getElementById('breadcrumb');
    let html = `<a href="#" id="home-link">Nigeria</a>`;
    
    if (currentState) {
        html += ` > <a href="#" id="state-link">${currentState}</a>`;
    }
    
    breadcrumb.innerHTML = html;
    
    document.getElementById('home-link').addEventListener('click', function(e) {
        e.preventDefault();
        loadMap('nigeria');
    });
    
    if (currentState) {
        document.getElementById('state-link').addEventListener('click', function(e) {
            e.preventDefault();
            loadMap('state', currentState);
        });
    }
}

function updateTitle(title) {
    document.getElementById('map-title').textContent = title;
}

function setupEventListeners() {
    document.getElementById('zoom-in').addEventListener('click', function() {
        svg.transition().duration(300).call(zoom.scaleBy, 1.5);
    });
    
    document.getElementById('zoom-out').addEventListener('click', function() {
        svg.transition().duration(300).call(zoom.scaleBy, 0.75);
    });
    
    document.getElementById('reset-view').addEventListener('click', function() {
        resetZoom();
    });
    
    closeModalBtn.addEventListener('click', function() {
        systemModal.style.display = "none";
    });
    
    window.addEventListener('click', function(event) {
        if (event.target === systemModal) {
            systemModal.style.display = "none";
        }
    });
    
    window.addEventListener('resize', function() {
        width = document.getElementById('map-wrapper').clientWidth;
        height = document.getElementById('map-wrapper').clientHeight;
        
        svg.attr("width", width)
            .attr("height", height);
            
        resetZoom();
    });
}

function updateSystemStats() {
    let totalSystems = energySystemData.nigeria.beams.length;
    let activeSystems = 0;
    let inactiveSystems = 0;
    let statesCovered = new Set();
    let lgasCovered = new Set();
    
    energySystemData.nigeria.beams.forEach(beam => {
        if (beam.active) {
            activeSystems++;
        } else {
            inactiveSystems++;
        }
        statesCovered.add(beam.state);
    });
    
    Object.keys(energySystemData.states).forEach(state => {
        if (energySystemData.states[state].beams) {
            energySystemData.states[state].beams.forEach(beam => {
                lgasCovered.add(beam.lga);
            });
        }
    });
    
    document.getElementById('total-systems').textContent = totalSystems;
    document.getElementById('active-systems').textContent = activeSystems;
    document.getElementById('inactive-systems').textContent = inactiveSystems;
    document.getElementById('states-covered').textContent = statesCovered.size;
    document.getElementById('lgas-covered').textContent = lgasCovered.size;
}