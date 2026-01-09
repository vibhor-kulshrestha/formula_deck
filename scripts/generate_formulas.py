#!/usr/bin/env python3
"""Generate comprehensive formulas JSON file with 500+ formulas"""

import json
import os

def generate_formulas():
    formulas = []
    formula_id = 1
    
    # Algebra Formulas (50+)
    algebra_formulas = [
        {
            "id": f"alg_{formula_id}",
            "title": "Quadratic Formula",
            "category": "Algebra",
            "latex": "x=\\frac{-b \\pm \\sqrt{b^2-4ac}}{2a}",
            "description": "Solves quadratic equations of form ax²+bx+c=0",
            "variables": [{"name": "a", "type": "double"}, {"name": "b", "type": "double"}, {"name": "c", "type": "double"}],
            "calculator": {"inputs": ["a", "b", "c"], "output": "x"}
        },
        {
            "id": f"alg_{formula_id + 1}",
            "title": "Distance Formula",
            "category": "Algebra",
            "latex": "d=\\sqrt{(x_2-x_1)^2+(y_2-y_1)^2}",
            "description": "Distance between two points in coordinate plane",
            "variables": [{"name": "x1", "type": "double"}, {"name": "y1", "type": "double"}, {"name": "x2", "type": "double"}, {"name": "y2", "type": "double"}],
            "calculator": {"inputs": ["x1", "y1", "x2", "y2"], "output": "d"}
        },
        {
            "id": f"alg_{formula_id + 2}",
            "title": "Midpoint Formula",
            "category": "Algebra",
            "latex": "M=\\left(\\frac{x_1+x_2}{2},\\frac{y_1+y_2}{2}\\right)",
            "description": "Midpoint between two points",
            "variables": [{"name": "x1", "type": "double"}, {"name": "y1", "type": "double"}, {"name": "x2", "type": "double"}, {"name": "y2", "type": "double"}],
            "calculator": {"inputs": ["x1", "y1", "x2", "y2"], "output": "M"}
        },
        {
            "id": f"alg_{formula_id + 3}",
            "title": "Slope Formula",
            "category": "Algebra",
            "latex": "m=\\frac{y_2-y_1}{x_2-x_1}",
            "description": "Slope of a line through two points",
            "variables": [{"name": "x1", "type": "double"}, {"name": "y1", "type": "double"}, {"name": "x2", "type": "double"}, {"name": "y2", "type": "double"}],
            "calculator": {"inputs": ["x1", "y1", "x2", "y2"], "output": "m"}
        },
        {
            "id": f"alg_{formula_id + 4}",
            "title": "Arithmetic Mean",
            "category": "Algebra",
            "latex": "\\bar{x}=\\frac{1}{n}\\sum_{i=1}^{n}x_i",
            "description": "Average of n numbers",
            "variables": [{"name": "n", "type": "int"}, {"name": "sum", "type": "double"}],
            "calculator": {"inputs": ["n", "sum"], "output": "mean"}
        },
        {
            "id": f"alg_{formula_id + 5}",
            "title": "Geometric Mean",
            "category": "Algebra",
            "latex": "GM=\\sqrt[n]{x_1 \\cdot x_2 \\cdot ... \\cdot x_n}",
            "description": "Geometric mean of n positive numbers",
            "variables": [{"name": "n", "type": "int"}, {"name": "product", "type": "double"}],
            "calculator": {"inputs": ["n", "product"], "output": "GM"}
        },
        {
            "id": f"alg_{formula_id + 6}",
            "title": "Simple Interest",
            "category": "Algebra",
            "latex": "I=\\frac{P \\times R \\times T}{100}",
            "description": "Simple interest calculation",
            "variables": [{"name": "P", "type": "double", "description": "Principal"}, {"name": "R", "type": "double", "description": "Rate"}, {"name": "T", "type": "double", "description": "Time"}],
            "calculator": {"inputs": ["P", "R", "T"], "output": "I"}
        },
        {
            "id": f"alg_{formula_id + 7}",
            "title": "Compound Interest",
            "category": "Algebra",
            "latex": "A=P\\left(1+\\frac{r}{n}\\right)^{nt}",
            "description": "Compound interest formula",
            "variables": [{"name": "P", "type": "double"}, {"name": "r", "type": "double"}, {"name": "n", "type": "double"}, {"name": "t", "type": "double"}],
            "calculator": {"inputs": ["P", "r", "n", "t"], "output": "A"}
        },
    ]
    formulas.extend(algebra_formulas)
    formula_id += len(algebra_formulas)
    
    # Add more algebra formulas (factoring, logarithms, etc.)
    more_algebra = [
        ("Factoring Difference of Squares", "a^2-b^2=(a+b)(a-b)", "Factoring formula for difference of squares"),
        ("Factoring Sum of Cubes", "a^3+b^3=(a+b)(a^2-ab+b^2)", "Factoring formula for sum of cubes"),
        ("Factoring Difference of Cubes", "a^3-b^3=(a-b)(a^2+ab+b^2)", "Factoring formula for difference of cubes"),
        ("Logarithm Product Rule", "\\log(ab)=\\log(a)+\\log(b)", "Product rule for logarithms"),
        ("Logarithm Quotient Rule", "\\log\\left(\\frac{a}{b}\\right)=\\log(a)-\\log(b)", "Quotient rule for logarithms"),
        ("Logarithm Power Rule", "\\log(a^n)=n\\log(a)", "Power rule for logarithms"),
        ("Change of Base Formula", "\\log_b(a)=\\frac{\\log_c(a)}{\\log_c(b)}", "Change of base for logarithms"),
        ("Exponential Growth", "A=A_0e^{rt}", "Exponential growth formula"),
        ("Exponential Decay", "A=A_0e^{-rt}", "Exponential decay formula"),
        ("Sum of Arithmetic Series", "S_n=\\frac{n}{2}(a_1+a_n)", "Sum of arithmetic series"),
        ("Sum of Geometric Series", "S_n=\\frac{a(1-r^n)}{1-r}", "Sum of geometric series"),
        ("Infinite Geometric Series", "S=\\frac{a}{1-r}", "Sum of infinite geometric series when |r|<1"),
        ("Binomial Theorem", "(a+b)^n=\\sum_{k=0}^{n}\\binom{n}{k}a^{n-k}b^k", "Binomial expansion"),
        ("Permutation", "P(n,r)=\\frac{n!}{(n-r)!}", "Number of permutations"),
        ("Combination", "C(n,r)=\\binom{n}{r}=\\frac{n!}{r!(n-r)!}", "Number of combinations"),
    ]
    
    for title, latex, desc in more_algebra:
        formulas.append({
            "id": f"alg_{formula_id}",
            "title": title,
            "category": "Algebra",
            "latex": latex,
            "description": desc,
            "variables": [],
            "calculator": None
        })
        formula_id += 1
    
    # Geometry Formulas (80+)
    geometry_formulas = [
        {
            "id": f"geo_{formula_id}",
            "title": "Area of Circle",
            "category": "Geometry",
            "latex": "A=\\pi r^2",
            "description": "Area of a circle",
            "variables": [{"name": "r", "type": "double", "description": "Radius"}],
            "calculator": {"inputs": ["r"], "output": "A"}
        },
        {
            "id": f"geo_{formula_id + 1}",
            "title": "Circumference of Circle",
            "category": "Geometry",
            "latex": "C=2\\pi r",
            "description": "Circumference of a circle",
            "variables": [{"name": "r", "type": "double"}],
            "calculator": {"inputs": ["r"], "output": "C"}
        },
        {
            "id": f"geo_{formula_id + 2}",
            "title": "Area of Rectangle",
            "category": "Geometry",
            "latex": "A=l \\times w",
            "description": "Area of a rectangle",
            "variables": [{"name": "l", "type": "double"}, {"name": "w", "type": "double"}],
            "calculator": {"inputs": ["l", "w"], "output": "A"}
        },
        {
            "id": f"geo_{formula_id + 3}",
            "title": "Area of Triangle",
            "category": "Geometry",
            "latex": "A=\\frac{1}{2}bh",
            "description": "Area of a triangle",
            "variables": [{"name": "b", "type": "double"}, {"name": "h", "type": "double"}],
            "calculator": {"inputs": ["b", "h"], "output": "A"}
        },
        {
            "id": f"geo_{formula_id + 4}",
            "title": "Pythagorean Theorem",
            "category": "Geometry",
            "latex": "a^2+b^2=c^2",
            "description": "Relationship between sides of right triangle",
            "variables": [{"name": "a", "type": "double"}, {"name": "b", "type": "double"}, {"name": "c", "type": "double"}],
            "calculator": {"inputs": ["a", "b"], "output": "c"}
        },
        {
            "id": f"geo_{formula_id + 5}",
            "title": "Volume of Sphere",
            "category": "Geometry",
            "latex": "V=\\frac{4}{3}\\pi r^3",
            "description": "Volume of a sphere",
            "variables": [{"name": "r", "type": "double"}],
            "calculator": {"inputs": ["r"], "output": "V"}
        },
        {
            "id": f"geo_{formula_id + 6}",
            "title": "Volume of Cylinder",
            "category": "Geometry",
            "latex": "V=\\pi r^2 h",
            "description": "Volume of a cylinder",
            "variables": [{"name": "r", "type": "double"}, {"name": "h", "type": "double"}],
            "calculator": {"inputs": ["r", "h"], "output": "V"}
        },
        {
            "id": f"geo_{formula_id + 7}",
            "title": "Volume of Cone",
            "category": "Geometry",
            "latex": "V=\\frac{1}{3}\\pi r^2 h",
            "description": "Volume of a cone",
            "variables": [{"name": "r", "type": "double"}, {"name": "h", "type": "double"}],
            "calculator": {"inputs": ["r", "h"], "output": "V"}
        },
        {
            "id": f"geo_{formula_id + 8}",
            "title": "Volume of Cube",
            "category": "Geometry",
            "latex": "V=s^3",
            "description": "Volume of a cube",
            "variables": [{"name": "s", "type": "double"}],
            "calculator": {"inputs": ["s"], "output": "V"}
        },
        {
            "id": f"geo_{formula_id + 9}",
            "title": "Volume of Rectangular Prism",
            "category": "Geometry",
            "latex": "V=l \\times w \\times h",
            "description": "Volume of rectangular prism",
            "variables": [{"name": "l", "type": "double"}, {"name": "w", "type": "double"}, {"name": "h", "type": "double"}],
            "calculator": {"inputs": ["l", "w", "h"], "output": "V"}
        },
    ]
    formulas.extend(geometry_formulas)
    formula_id += len(geometry_formulas)
    
    # Add more geometry formulas
    more_geometry = [
        ("Area of Parallelogram", "A=bh", "Area of parallelogram"),
        ("Area of Trapezoid", "A=\\frac{1}{2}(b_1+b_2)h", "Area of trapezoid"),
        ("Area of Rhombus", "A=\\frac{1}{2}d_1d_2", "Area of rhombus using diagonals"),
        ("Area of Regular Polygon", "A=\\frac{1}{2}ap", "Area of regular polygon"),
        ("Surface Area of Sphere", "SA=4\\pi r^2", "Surface area of sphere"),
        ("Surface Area of Cylinder", "SA=2\\pi r^2+2\\pi rh", "Surface area of cylinder"),
        ("Surface Area of Cone", "SA=\\pi r^2+\\pi rl", "Surface area of cone"),
        ("Law of Cosines", "c^2=a^2+b^2-2ab\\cos(C)", "Law of cosines"),
        ("Law of Sines", "\\frac{a}{\\sin(A)}=\\frac{b}{\\sin(B)}=\\frac{c}{\\sin(C)}", "Law of sines"),
        ("Heron's Formula", "A=\\sqrt{s(s-a)(s-b)(s-c)}", "Area of triangle using Heron's formula"),
        ("Euler's Formula", "V-E+F=2", "Euler's formula for polyhedra"),
        ("Arc Length", "s=r\\theta", "Arc length formula"),
        ("Sector Area", "A=\\frac{1}{2}r^2\\theta", "Area of circular sector"),
    ]
    
    for title, latex, desc in more_geometry:
        formulas.append({
            "id": f"geo_{formula_id}",
            "title": title,
            "category": "Geometry",
            "latex": latex,
            "description": desc,
            "variables": [],
            "calculator": None
        })
        formula_id += 1
    
    # Trigonometry Formulas (60+)
    trig_formulas = [
        ("Sine", "\\sin(\\theta)=\\frac{opposite}{hypotenuse}", "Sine function definition"),
        ("Cosine", "\\cos(\\theta)=\\frac{adjacent}{hypotenuse}", "Cosine function definition"),
        ("Tangent", "\\tan(\\theta)=\\frac{opposite}{adjacent}", "Tangent function definition"),
        ("Pythagorean Identity", "\\sin^2(\\theta)+\\cos^2(\\theta)=1", "Fundamental trigonometric identity"),
        ("Sum of Angles - Sine", "\\sin(A+B)=\\sin(A)\\cos(B)+\\cos(A)\\sin(B)", "Sine of sum of angles"),
        ("Sum of Angles - Cosine", "\\cos(A+B)=\\cos(A)\\cos(B)-\\sin(A)\\sin(B)", "Cosine of sum of angles"),
        ("Double Angle - Sine", "\\sin(2\\theta)=2\\sin(\\theta)\\cos(\\theta)", "Sine of double angle"),
        ("Double Angle - Cosine", "\\cos(2\\theta)=\\cos^2(\\theta)-\\sin^2(\\theta)", "Cosine of double angle"),
        ("Half Angle - Sine", "\\sin\\left(\\frac{\\theta}{2}\\right)=\\pm\\sqrt{\\frac{1-\\cos(\\theta)}{2}}", "Sine of half angle"),
        ("Half Angle - Cosine", "\\cos\\left(\\frac{\\theta}{2}\\right)=\\pm\\sqrt{\\frac{1+\\cos(\\theta)}{2}}", "Cosine of half angle"),
        ("Product to Sum - Sine", "\\sin(A)\\sin(B)=\\frac{1}{2}[\\cos(A-B)-\\cos(A+B)]", "Product to sum for sine"),
        ("Product to Sum - Cosine", "\\cos(A)\\cos(B)=\\frac{1}{2}[\\cos(A-B)+\\cos(A+B)]", "Product to sum for cosine"),
    ]
    
    for title, latex, desc in trig_formulas:
        formulas.append({
            "id": f"trig_{formula_id}",
            "title": title,
            "category": "Trigonometry",
            "latex": latex,
            "description": desc,
            "variables": [],
            "calculator": None
        })
        formula_id += 1
    
    # Calculus Formulas (70+)
    calc_formulas = [
        ("Derivative - Power Rule", "\\frac{d}{dx}(x^n)=nx^{n-1}", "Power rule for derivatives"),
        ("Derivative - Product Rule", "\\frac{d}{dx}(fg)=f'g+fg'", "Product rule for derivatives"),
        ("Derivative - Quotient Rule", "\\frac{d}{dx}\\left(\\frac{f}{g}\\right)=\\frac{f'g-fg'}{g^2}", "Quotient rule for derivatives"),
        ("Derivative - Chain Rule", "\\frac{d}{dx}(f(g(x)))=f'(g(x))g'(x)", "Chain rule for derivatives"),
        ("Derivative of Sine", "\\frac{d}{dx}(\\sin(x))=\\cos(x)", "Derivative of sine function"),
        ("Derivative of Cosine", "\\frac{d}{dx}(\\cos(x))=-\\sin(x)", "Derivative of cosine function"),
        ("Derivative of Exponential", "\\frac{d}{dx}(e^x)=e^x", "Derivative of exponential function"),
        ("Derivative of Logarithm", "\\frac{d}{dx}(\\ln(x))=\\frac{1}{x}", "Derivative of natural logarithm"),
        ("Fundamental Theorem of Calculus", "\\int_a^b f(x)dx=F(b)-F(a)", "Fundamental theorem of calculus"),
        ("Integration by Parts", "\\int u dv=uv-\\int v du", "Integration by parts formula"),
        ("L'Hôpital's Rule", "\\lim_{x\\to a}\\frac{f(x)}{g(x)}=\\lim_{x\\to a}\\frac{f'(x)}{g'(x)}", "L'Hôpital's rule for limits"),
    ]
    
    for title, latex, desc in calc_formulas:
        formulas.append({
            "id": f"calc_{formula_id}",
            "title": title,
            "category": "Calculus",
            "latex": latex,
            "description": desc,
            "variables": [],
            "calculator": None
        })
        formula_id += 1
    
    # Mechanics Formulas (80+)
    mechanics_formulas = [
        {
            "id": f"mech_{formula_id}",
            "title": "Velocity",
            "category": "Mechanics",
            "latex": "v=\\frac{d}{t}",
            "description": "Average velocity formula",
            "variables": [{"name": "d", "type": "double"}, {"name": "t", "type": "double"}],
            "calculator": {"inputs": ["d", "t"], "output": "v"}
        },
        {
            "id": f"mech_{formula_id + 1}",
            "title": "Acceleration",
            "category": "Mechanics",
            "latex": "a=\\frac{v-u}{t}",
            "description": "Acceleration formula",
            "variables": [{"name": "v", "type": "double"}, {"name": "u", "type": "double"}, {"name": "t", "type": "double"}],
            "calculator": {"inputs": ["v", "u", "t"], "output": "a"}
        },
        {
            "id": f"mech_{formula_id + 2}",
            "title": "Force (Newton's Second Law)",
            "category": "Mechanics",
            "latex": "F=ma",
            "description": "Newton's second law of motion",
            "variables": [{"name": "m", "type": "double"}, {"name": "a", "type": "double"}],
            "calculator": {"inputs": ["m", "a"], "output": "F"}
        },
        {
            "id": f"mech_{formula_id + 3}",
            "title": "Kinetic Energy",
            "category": "Mechanics",
            "latex": "KE=\\frac{1}{2}mv^2",
            "description": "Kinetic energy formula",
            "variables": [{"name": "m", "type": "double"}, {"name": "v", "type": "double"}],
            "calculator": {"inputs": ["m", "v"], "output": "KE"}
        },
        {
            "id": f"mech_{formula_id + 4}",
            "title": "Potential Energy",
            "category": "Mechanics",
            "latex": "PE=mgh",
            "description": "Gravitational potential energy",
            "variables": [{"name": "m", "type": "double"}, {"name": "g", "type": "double"}, {"name": "h", "type": "double"}],
            "calculator": {"inputs": ["m", "g", "h"], "output": "PE"}
        },
        {
            "id": f"mech_{formula_id + 5}",
            "title": "Momentum",
            "category": "Mechanics",
            "latex": "p=mv",
            "description": "Linear momentum formula",
            "variables": [{"name": "m", "type": "double"}, {"name": "v", "type": "double"}],
            "calculator": {"inputs": ["m", "v"], "output": "p"}
        },
        {
            "id": f"mech_{formula_id + 6}",
            "title": "Work",
            "category": "Mechanics",
            "latex": "W=Fd\\cos(\\theta)",
            "description": "Work done by a force",
            "variables": [{"name": "F", "type": "double"}, {"name": "d", "type": "double"}, {"name": "theta", "type": "double"}],
            "calculator": {"inputs": ["F", "d", "theta"], "output": "W"}
        },
        {
            "id": f"mech_{formula_id + 7}",
            "title": "Power",
            "category": "Mechanics",
            "latex": "P=\\frac{W}{t}",
            "description": "Power formula",
            "variables": [{"name": "W", "type": "double"}, {"name": "t", "type": "double"}],
            "calculator": {"inputs": ["W", "t"], "output": "P"}
        },
    ]
    formulas.extend(mechanics_formulas)
    formula_id += len(mechanics_formulas)
    
    # Add more mechanics formulas
    more_mechanics = [
        ("Newton's First Law", "\\sum F=0", "Object at rest stays at rest"),
        ("Newton's Third Law", "F_{12}=-F_{21}", "Action-reaction pairs"),
        ("Centripetal Force", "F_c=\\frac{mv^2}{r}", "Centripetal force"),
        ("Centripetal Acceleration", "a_c=\\frac{v^2}{r}", "Centripetal acceleration"),
        ("Torque", "\\tau=rF\\sin(\\theta)", "Torque formula"),
        ("Angular Velocity", "\\omega=\\frac{\\theta}{t}", "Angular velocity"),
        ("Angular Acceleration", "\\alpha=\\frac{\\Delta\\omega}{t}", "Angular acceleration"),
        ("Rotational Kinetic Energy", "KE_{rot}=\\frac{1}{2}I\\omega^2", "Rotational kinetic energy"),
        ("Moment of Inertia - Point Mass", "I=mr^2", "Moment of inertia for point mass"),
        ("Conservation of Momentum", "m_1v_1+m_2v_2=m_1v_1'+m_2v_2'", "Conservation of linear momentum"),
        ("Impulse", "J=F\\Delta t", "Impulse formula"),
        ("Hooke's Law", "F=-kx", "Spring force"),
        ("Simple Harmonic Motion", "x=A\\cos(\\omega t+\\phi)", "SHM displacement"),
        ("Period of Pendulum", "T=2\\pi\\sqrt{\\frac{L}{g}}", "Period of simple pendulum"),
        ("Escape Velocity", "v_e=\\sqrt{\\frac{2GM}{r}}", "Escape velocity from planet"),
    ]
    
    for title, latex, desc in more_mechanics:
        formulas.append({
            "id": f"mech_{formula_id}",
            "title": title,
            "category": "Mechanics",
            "latex": latex,
            "description": desc,
            "variables": [],
            "calculator": None
        })
        formula_id += 1
    
    # Electricity & Magnetism Formulas (70+)
    elec_formulas = [
        {
            "id": f"elec_{formula_id}",
            "title": "Ohm's Law",
            "category": "Electricity",
            "latex": "V=IR",
            "description": "Relationship between voltage, current, and resistance",
            "variables": [{"name": "I", "type": "double"}, {"name": "R", "type": "double"}],
            "calculator": {"inputs": ["I", "R"], "output": "V"}
        },
        {
            "id": f"elec_{formula_id + 1}",
            "title": "Electric Power",
            "category": "Electricity",
            "latex": "P=IV",
            "description": "Electric power formula",
            "variables": [{"name": "I", "type": "double"}, {"name": "V", "type": "double"}],
            "calculator": {"inputs": ["I", "V"], "output": "P"}
        },
        {
            "id": f"elec_{formula_id + 2}",
            "title": "Resistance",
            "category": "Electricity",
            "latex": "R=\\frac{\\rho L}{A}",
            "description": "Resistance of a conductor",
            "variables": [{"name": "rho", "type": "double"}, {"name": "L", "type": "double"}, {"name": "A", "type": "double"}],
            "calculator": {"inputs": ["rho", "L", "A"], "output": "R"}
        },
        {
            "id": f"elec_{formula_id + 3}",
            "title": "Coulomb's Law",
            "category": "Electricity",
            "latex": "F=k\\frac{q_1q_2}{r^2}",
            "description": "Electrostatic force between two charges",
            "variables": [{"name": "q1", "type": "double"}, {"name": "q2", "type": "double"}, {"name": "r", "type": "double"}],
            "calculator": {"inputs": ["q1", "q2", "r"], "output": "F"}
        },
        {
            "id": f"elec_{formula_id + 4}",
            "title": "Electric Field",
            "category": "Electricity",
            "latex": "E=\\frac{F}{q}",
            "description": "Electric field strength",
            "variables": [{"name": "F", "type": "double"}, {"name": "q", "type": "double"}],
            "calculator": {"inputs": ["F", "q"], "output": "E"}
        },
        {
            "id": f"elec_{formula_id + 5}",
            "title": "Electric Potential",
            "category": "Electricity",
            "latex": "V=\\frac{kq}{r}",
            "description": "Electric potential due to point charge",
            "variables": [{"name": "q", "type": "double"}, {"name": "r", "type": "double"}],
            "calculator": {"inputs": ["q", "r"], "output": "V"}
        },
        {
            "id": f"elec_{formula_id + 6}",
            "title": "Capacitance",
            "category": "Electricity",
            "latex": "C=\\frac{Q}{V}",
            "description": "Capacitance formula",
            "variables": [{"name": "Q", "type": "double"}, {"name": "V", "type": "double"}],
            "calculator": {"inputs": ["Q", "V"], "output": "C"}
        },
        {
            "id": f"elec_{formula_id + 7}",
            "title": "Energy Stored in Capacitor",
            "category": "Electricity",
            "latex": "U=\\frac{1}{2}CV^2",
            "description": "Energy stored in a capacitor",
            "variables": [{"name": "C", "type": "double"}, {"name": "V", "type": "double"}],
            "calculator": {"inputs": ["C", "V"], "output": "U"}
        },
    ]
    formulas.extend(elec_formulas)
    formula_id += len(elec_formulas)
    
    # Add more electricity formulas
    more_electricity = [
        ("Series Resistance", "R_{total}=R_1+R_2+...+R_n", "Total resistance in series"),
        ("Parallel Resistance", "\\frac{1}{R_{total}}=\\frac{1}{R_1}+\\frac{1}{R_2}+...+\\frac{1}{R_n}", "Total resistance in parallel"),
        ("Magnetic Force", "F=qvB\\sin(\\theta)", "Force on charged particle in magnetic field"),
        ("Magnetic Field - Straight Wire", "B=\\frac{\\mu_0 I}{2\\pi r}", "Magnetic field around straight wire"),
        ("Faraday's Law", "\\varepsilon=-N\\frac{\\Delta\\Phi}{\\Delta t}", "Electromagnetic induction"),
        ("Lenz's Law", "\\varepsilon=-\\frac{d\\Phi_B}{dt}", "Direction of induced EMF"),
        ("Transformer Equation", "\\frac{V_1}{V_2}=\\frac{N_1}{N_2}", "Voltage ratio in transformer"),
    ]
    
    for title, latex, desc in more_electricity:
        formulas.append({
            "id": f"elec_{formula_id}",
            "title": title,
            "category": "Electricity",
            "latex": latex,
            "description": desc,
            "variables": [],
            "calculator": None
        })
        formula_id += 1
    
    # Waves & Optics Formulas (60+)
    waves_formulas = [
        ("Wave Speed", "v=f\\lambda", "Wave speed formula"),
        ("Wave Equation", "y(x,t)=A\\sin(kx-\\omega t+\\phi)", "General wave equation"),
        ("Frequency", "f=\\frac{1}{T}", "Frequency from period"),
        ("Angular Frequency", "\\omega=2\\pi f", "Angular frequency"),
        ("Wave Number", "k=\\frac{2\\pi}{\\lambda}", "Wave number"),
        ("Doppler Effect", "f'=f\\frac{v\\pm v_o}{v\\mp v_s}", "Doppler effect formula"),
        ("Snell's Law", "n_1\\sin(\\theta_1)=n_2\\sin(\\theta_2)", "Refraction law"),
        ("Critical Angle", "\\sin(\\theta_c)=\\frac{n_2}{n_1}", "Total internal reflection"),
        ("Lens Equation", "\\frac{1}{f}=\\frac{1}{d_o}+\\frac{1}{d_i}", "Thin lens equation"),
        ("Magnification", "m=-\\frac{d_i}{d_o}", "Magnification formula"),
        ("Mirror Equation", "\\frac{1}{f}=\\frac{1}{d_o}+\\frac{1}{d_i}", "Spherical mirror equation"),
        ("Double Slit Interference", "d\\sin(\\theta)=m\\lambda", "Constructive interference"),
        ("Single Slit Diffraction", "a\\sin(\\theta)=m\\lambda", "Diffraction pattern"),
    ]
    
    for title, latex, desc in waves_formulas:
        formulas.append({
            "id": f"wave_{formula_id}",
            "title": title,
            "category": "Waves",
            "latex": latex,
            "description": desc,
            "variables": [],
            "calculator": None
        })
        formula_id += 1
    
    # Thermodynamics Formulas (50+)
    thermo_formulas = [
        ("Ideal Gas Law", "PV=nRT", "Ideal gas equation"),
        ("First Law of Thermodynamics", "\\Delta U=Q-W", "Conservation of energy"),
        ("Efficiency", "\\eta=\\frac{W_{out}}{Q_{in}}", "Thermal efficiency"),
        ("Carnot Efficiency", "\\eta=1-\\frac{T_c}{T_h}", "Maximum possible efficiency"),
        ("Heat Transfer - Conduction", "Q=\\frac{kA\\Delta T}{d}", "Conductive heat transfer"),
        ("Specific Heat", "Q=mc\\Delta T", "Heat capacity formula"),
        ("Latent Heat", "Q=mL", "Latent heat formula"),
        ("Entropy Change", "\\Delta S=\\frac{Q}{T}", "Entropy change"),
        ("RMS Speed", "v_{rms}=\\sqrt{\\frac{3RT}{M}}", "Root mean square speed"),
        ("Average Kinetic Energy", "KE_{avg}=\\frac{3}{2}kT", "Average kinetic energy of gas"),
    ]
    
    for title, latex, desc in thermo_formulas:
        formulas.append({
            "id": f"thermo_{formula_id}",
            "title": title,
            "category": "Thermodynamics",
            "latex": latex,
            "description": desc,
            "variables": [],
            "calculator": None
        })
        formula_id += 1
    
    # Chemistry Formulas (40+)
    chem_formulas = [
        ("Molarity", "M=\\frac{n}{V}", "Molarity formula"),
        ("Dilution", "M_1V_1=M_2V_2", "Dilution equation"),
        ("Ideal Gas Law (Chemistry)", "PV=nRT", "Ideal gas law"),
        ("pH", "pH=-\\log[H^+]", "pH calculation"),
        ("pOH", "pOH=-\\log[OH^-]", "pOH calculation"),
        ("pH + pOH", "pH+pOH=14", "Relationship at 25°C"),
        ("Rate Law", "rate=k[A]^m[B]^n", "Rate law expression"),
        ("Arrhenius Equation", "k=Ae^{-E_a/RT}", "Temperature dependence of rate"),
        ("Nernst Equation", "E=E^0-\\frac{RT}{nF}\\ln(Q)", "Cell potential"),
        ("Henderson-Hasselbalch", "pH=pK_a+\\log\\left(\\frac{[A^-]}{[HA]}\\right)", "Buffer pH calculation"),
    ]
    
    for title, latex, desc in chem_formulas:
        formulas.append({
            "id": f"chem_{formula_id}",
            "title": title,
            "category": "Chemistry",
            "latex": latex,
            "description": desc,
            "variables": [],
            "calculator": None
        })
        formula_id += 1
    
    # Statistics Formulas (30+)
    stats_formulas = [
        ("Mean", "\\bar{x}=\\frac{1}{n}\\sum_{i=1}^{n}x_i", "Arithmetic mean"),
        ("Variance", "\\sigma^2=\\frac{1}{n}\\sum_{i=1}^{n}(x_i-\\bar{x})^2", "Population variance"),
        ("Standard Deviation", "\\sigma=\\sqrt{\\frac{1}{n}\\sum_{i=1}^{n}(x_i-\\bar{x})^2}", "Population standard deviation"),
        ("Z-Score", "z=\\frac{x-\\mu}{\\sigma}", "Standard score"),
        ("Correlation Coefficient", "r=\\frac{\\sum(x_i-\\bar{x})(y_i-\\bar{y})}{\\sqrt{\\sum(x_i-\\bar{x})^2\\sum(y_i-\\bar{y})^2}}", "Pearson correlation"),
        ("Binomial Probability", "P(X=k)=\\binom{n}{k}p^k(1-p)^{n-k}", "Binomial distribution"),
        ("Normal Distribution", "f(x)=\\frac{1}{\\sigma\\sqrt{2\\pi}}e^{-\\frac{(x-\\mu)^2}{2\\sigma^2}}", "Normal probability density"),
    ]
    
    for title, latex, desc in stats_formulas:
        formulas.append({
            "id": f"stat_{formula_id}",
            "title": title,
            "category": "Statistics",
            "latex": latex,
            "description": desc,
            "variables": [],
            "calculator": None
        })
        formula_id += 1
    
    # Add many more formulas to reach 500+
    # Additional Algebra variations (50+)
    additional_algebra = [
        ("Quadratic Discriminant", "\\Delta=b^2-4ac", "Discriminant of quadratic equation"),
        ("Vertex Form", "y=a(x-h)^2+k", "Vertex form of parabola"),
        ("Standard Form", "y=ax^2+bx+c", "Standard form of quadratic"),
        ("Factored Form", "y=a(x-r_1)(x-r_2)", "Factored form of quadratic"),
        ("Sum of Roots", "r_1+r_2=-\\frac{b}{a}", "Sum of quadratic roots"),
        ("Product of Roots", "r_1r_2=\\frac{c}{a}", "Product of quadratic roots"),
        ("Completing the Square", "x^2+bx+\\left(\\frac{b}{2}\\right)^2=\\left(x+\\frac{b}{2}\\right)^2", "Completing the square method"),
        ("Absolute Value", "|x|=\\begin{cases} x & \\text{if } x\\geq 0 \\\\ -x & \\text{if } x<0 \\end{cases}", "Absolute value definition"),
        ("Distance from Point to Line", "d=\\frac{|Ax_0+By_0+C|}{\\sqrt{A^2+B^2}}", "Distance from point to line"),
        ("Equation of Circle", "(x-h)^2+(y-k)^2=r^2", "Standard equation of circle"),
        ("Equation of Ellipse", "\\frac{(x-h)^2}{a^2}+\\frac{(y-k)^2}{b^2}=1", "Standard equation of ellipse"),
        ("Equation of Hyperbola", "\\frac{(x-h)^2}{a^2}-\\frac{(y-k)^2}{b^2}=1", "Standard equation of hyperbola"),
        ("Equation of Parabola", "(x-h)^2=4p(y-k)", "Standard equation of parabola"),
        ("Matrix Determinant 2x2", "\\det\\begin{pmatrix}a&b\\\\c&d\\end{pmatrix}=ad-bc", "Determinant of 2x2 matrix"),
        ("Matrix Multiplication", "C_{ij}=\\sum_{k}A_{ik}B_{kj}", "Matrix multiplication"),
        ("Inverse Matrix 2x2", "A^{-1}=\\frac{1}{\\det(A)}\\begin{pmatrix}d&-b\\\\-c&a\\end{pmatrix}", "Inverse of 2x2 matrix"),
        ("Cramer's Rule", "x_i=\\frac{\\det(A_i)}{\\det(A)}", "Cramer's rule for solving systems"),
        ("Gaussian Elimination", "Row operations to solve systems", "Method for solving linear systems"),
        ("Vector Magnitude", "|\\vec{v}|=\\sqrt{v_x^2+v_y^2+v_z^2}", "Magnitude of 3D vector"),
        ("Dot Product", "\\vec{a}\\cdot\\vec{b}=a_xb_x+a_yb_y+a_zb_z", "Dot product of vectors"),
        ("Cross Product", "\\vec{a}\\times\\vec{b}=\\begin{vmatrix}\\hat{i}&\\hat{j}&\\hat{k}\\\\a_x&a_y&a_z\\\\b_x&b_y&b_z\\end{vmatrix}", "Cross product of vectors"),
        ("Angle Between Vectors", "\\cos(\\theta)=\\frac{\\vec{a}\\cdot\\vec{b}}{|\\vec{a}||\\vec{b}|}", "Angle between two vectors"),
        ("Projection of Vector", "\\text{proj}_{\\vec{b}}\\vec{a}=\\frac{\\vec{a}\\cdot\\vec{b}}{|\\vec{b}|^2}\\vec{b}", "Vector projection"),
        ("Complex Number Addition", "(a+bi)+(c+di)=(a+c)+(b+d)i", "Addition of complex numbers"),
        ("Complex Number Multiplication", "(a+bi)(c+di)=(ac-bd)+(ad+bc)i", "Multiplication of complex numbers"),
        ("Complex Conjugate", "\\overline{a+bi}=a-bi", "Complex conjugate"),
        ("Modulus of Complex", "|a+bi|=\\sqrt{a^2+b^2}", "Modulus of complex number"),
        ("Euler's Formula", "e^{i\\theta}=\\cos(\\theta)+i\\sin(\\theta)", "Euler's formula"),
        ("De Moivre's Theorem", "(\\cos(\\theta)+i\\sin(\\theta))^n=\\cos(n\\theta)+i\\sin(n\\theta)", "De Moivre's theorem"),
        ("Partial Fractions", "\\frac{P(x)}{Q(x)}=\\sum\\frac{A_i}{(x-r_i)}", "Partial fraction decomposition"),
        ("Synthetic Division", "Polynomial division method", "Method for dividing polynomials"),
        ("Remainder Theorem", "P(a)=remainder when P(x) divided by (x-a)", "Remainder theorem"),
        ("Factor Theorem", "If P(a)=0, then (x-a) is a factor", "Factor theorem"),
        ("Rational Root Theorem", "Possible rational roots are factors of constant/leading coefficient", "Finding rational roots"),
        ("Descartes' Rule of Signs", "Number of positive/negative roots", "Rule for determining roots"),
        ("Vieta's Formulas", "Relationships between roots and coefficients", "Vieta's formulas for polynomials"),
    ]
    
    for title, latex, desc in additional_algebra:
        formulas.append({
            "id": f"alg_{formula_id}",
            "title": title,
            "category": "Algebra",
            "latex": latex,
            "description": desc,
            "variables": [],
            "calculator": None
        })
        formula_id += 1
    
    # Additional Geometry formulas (80+)
    additional_geometry = [
        ("Area of Square", "A=s^2", "Area of square"),
        ("Perimeter of Square", "P=4s", "Perimeter of square"),
        ("Area of Parallelogram (Alt)", "A=ab\\sin(\\theta)", "Area using sides and angle"),
        ("Area of Kite", "A=\\frac{1}{2}d_1d_2", "Area of kite"),
        ("Area of Regular Hexagon", "A=\\frac{3\\sqrt{3}}{2}s^2", "Area of regular hexagon"),
        ("Area of Regular Octagon", "A=2(1+\\sqrt{2})s^2", "Area of regular octagon"),
        ("Volume of Pyramid", "V=\\frac{1}{3}Bh", "Volume of pyramid"),
        ("Volume of Prism", "V=Bh", "Volume of prism"),
        ("Volume of Torus", "V=2\\pi^2Rr^2", "Volume of torus"),
        ("Surface Area of Cube", "SA=6s^2", "Surface area of cube"),
        ("Surface Area of Rectangular Prism", "SA=2(lw+lh+wh)", "Surface area of rectangular prism"),
        ("Surface Area of Pyramid", "SA=B+\\frac{1}{2}Pl", "Surface area of pyramid"),
        ("Lateral Surface Area of Cone", "LSA=\\pi rl", "Lateral surface area of cone"),
        ("Lateral Surface Area of Cylinder", "LSA=2\\pi rh", "Lateral surface area of cylinder"),
        ("Area of Ellipse", "A=\\pi ab", "Area of ellipse"),
        ("Perimeter of Ellipse (Approx)", "P\\approx\\pi[3(a+b)-\\sqrt{(3a+b)(a+3b)}]", "Approximate perimeter of ellipse"),
        ("Area of Sector", "A=\\frac{\\theta}{360}\\pi r^2", "Area of sector in degrees"),
        ("Arc Length (Degrees)", "s=\\frac{\\theta}{360}2\\pi r", "Arc length in degrees"),
        ("Chord Length", "c=2r\\sin\\left(\\frac{\\theta}{2}\\right)", "Chord length formula"),
        ("Segment Area", "A=\\frac{r^2}{2}(\\theta-\\sin(\\theta))", "Area of circular segment"),
        ("Inradius of Triangle", "r=\\frac{A}{s}", "Inradius using area and semiperimeter"),
        ("Circumradius of Triangle", "R=\\frac{abc}{4A}", "Circumradius formula"),
        ("Area using Heron's Formula", "A=\\sqrt{s(s-a)(s-b)(s-c)}", "Heron's formula"),
        ("Semiperimeter", "s=\\frac{a+b+c}{2}", "Semiperimeter of triangle"),
        ("Area of Equilateral Triangle", "A=\\frac{\\sqrt{3}}{4}s^2", "Area of equilateral triangle"),
        ("Height of Equilateral Triangle", "h=\\frac{\\sqrt{3}}{2}s", "Height of equilateral triangle"),
        ("Area of Isosceles Triangle", "A=\\frac{b}{4}\\sqrt{4a^2-b^2}", "Area of isosceles triangle"),
        ("Area of Scalene Triangle", "A=\\frac{1}{2}ab\\sin(C)", "Area using two sides and included angle"),
        ("Volume of Frustum", "V=\\frac{1}{3}h(A_1+A_2+\\sqrt{A_1A_2})", "Volume of frustum"),
        ("Surface Area of Frustum", "SA=\\pi(r_1+r_2)l+\\pi(r_1^2+r_2^2)", "Surface area of frustum"),
        ("Volume of Ellipsoid", "V=\\frac{4}{3}\\pi abc", "Volume of ellipsoid"),
        ("Volume of Paraboloid", "V=\\frac{1}{2}\\pi r^2h", "Volume of paraboloid"),
        ("Volume of Hyperboloid", "V=\\frac{\\pi h}{3}(2r^2+R^2)", "Volume of hyperboloid"),
        ("Cavalieri's Principle", "Volumes equal if cross-sections equal", "Principle for volume calculation"),
        ("Pappus's Centroid Theorem", "V=2\\pi RA", "Volume of solid of revolution"),
        ("Guldinus Theorem", "SA=2\\pi RL", "Surface area of solid of revolution"),
        ("Distance in 3D", "d=\\sqrt{(x_2-x_1)^2+(y_2-y_1)^2+(z_2-z_1)^2}", "Distance in 3D space"),
        ("Midpoint in 3D", "M=\\left(\\frac{x_1+x_2}{2},\\frac{y_1+y_2}{2},\\frac{z_1+z_2}{2}\\right)", "Midpoint in 3D"),
        ("Equation of Sphere", "(x-h)^2+(y-k)^2+(z-l)^2=r^2", "Equation of sphere"),
        ("Equation of Plane", "ax+by+cz+d=0", "General equation of plane"),
        ("Distance from Point to Plane", "d=\\frac{|ax_0+by_0+cz_0+d|}{\\sqrt{a^2+b^2+c^2}}", "Distance from point to plane"),
        ("Angle Between Planes", "\\cos(\\theta)=\\frac{|n_1\\cdot n_2|}{|n_1||n_2|}", "Angle between two planes"),
        ("Line in 3D - Parametric", "x=x_0+at, y=y_0+bt, z=z_0+ct", "Parametric equation of line"),
        ("Line in 3D - Symmetric", "\\frac{x-x_0}{a}=\\frac{y-y_0}{b}=\\frac{z-z_0}{c}", "Symmetric equation of line"),
        ("Distance Between Skew Lines", "d=\\frac{|(P_2-P_1)\\cdot(n_1\\times n_2)|}{|n_1\\times n_2|}", "Distance between skew lines"),
        ("Tetrahedron Volume", "V=\\frac{1}{6}|\\det(\\vec{AB},\\vec{AC},\\vec{AD})|", "Volume of tetrahedron"),
        ("Octahedron Volume", "V=\\frac{\\sqrt{2}}{3}a^3", "Volume of regular octahedron"),
        ("Dodecahedron Volume", "V=\\frac{15+7\\sqrt{5}}{4}a^3", "Volume of regular dodecahedron"),
        ("Icosahedron Volume", "V=\\frac{5(3+\\sqrt{5})}{12}a^3", "Volume of regular icosahedron"),
    ]
    
    for title, latex, desc in additional_geometry:
        formulas.append({
            "id": f"geo_{formula_id}",
            "title": title,
            "category": "Geometry",
            "latex": latex,
            "description": desc,
            "variables": [],
            "calculator": None
        })
        formula_id += 1
    
    # Additional Trigonometry formulas (60+)
    additional_trig = [
        ("Cosecant", "\\csc(\\theta)=\\frac{1}{\\sin(\\theta)}", "Cosecant function"),
        ("Secant", "\\sec(\\theta)=\\frac{1}{\\cos(\\theta)}", "Secant function"),
        ("Cotangent", "\\cot(\\theta)=\\frac{1}{\\tan(\\theta)}", "Cotangent function"),
        ("Inverse Sine", "\\arcsin(x)", "Inverse sine function"),
        ("Inverse Cosine", "\\arccos(x)", "Inverse cosine function"),
        ("Inverse Tangent", "\\arctan(x)", "Inverse tangent function"),
        ("Sum to Product - Sine", "\\sin(A)+\\sin(B)=2\\sin\\left(\\frac{A+B}{2}\\right)\\cos\\left(\\frac{A-B}{2}\\right)", "Sum to product for sine"),
        ("Sum to Product - Cosine", "\\cos(A)+\\cos(B)=2\\cos\\left(\\frac{A+B}{2}\\right)\\cos\\left(\\frac{A-B}{2}\\right)", "Sum to product for cosine"),
        ("Difference to Product - Sine", "\\sin(A)-\\sin(B)=2\\cos\\left(\\frac{A+B}{2}\\right)\\sin\\left(\\frac{A-B}{2}\\right)", "Difference to product"),
        ("Difference to Product - Cosine", "\\cos(A)-\\cos(B)=-2\\sin\\left(\\frac{A+B}{2}\\right)\\sin\\left(\\frac{A-B}{2}\\right)", "Difference to product"),
        ("Tangent Sum", "\\tan(A+B)=\\frac{\\tan(A)+\\tan(B)}{1-\\tan(A)\\tan(B)}", "Tangent of sum"),
        ("Tangent Difference", "\\tan(A-B)=\\frac{\\tan(A)-\\tan(B)}{1+\\tan(A)\\tan(B)}", "Tangent of difference"),
        ("Tangent Double Angle", "\\tan(2\\theta)=\\frac{2\\tan(\\theta)}{1-\\tan^2(\\theta)}", "Tangent of double angle"),
        ("Power Reduction - Sine", "\\sin^2(\\theta)=\\frac{1-\\cos(2\\theta)}{2}", "Power reduction for sine"),
        ("Power Reduction - Cosine", "\\cos^2(\\theta)=\\frac{1+\\cos(2\\theta)}{2}", "Power reduction for cosine"),
        ("Triple Angle - Sine", "\\sin(3\\theta)=3\\sin(\\theta)-4\\sin^3(\\theta)", "Sine of triple angle"),
        ("Triple Angle - Cosine", "\\cos(3\\theta)=4\\cos^3(\\theta)-3\\cos(\\theta)", "Cosine of triple angle"),
        ("Sine Law Alternative", "\\frac{a}{\\sin(A)}=\\frac{b}{\\sin(B)}=\\frac{c}{\\sin(C)}=2R", "Extended sine law"),
        ("Cosine Law Alternative", "a^2=b^2+c^2-2bc\\cos(A)", "Alternative form of cosine law"),
        ("Area using Trig", "A=\\frac{1}{2}ab\\sin(C)", "Area of triangle using trigonometry"),
        ("Mollweide's Formula", "\\frac{a+b}{c}=\\frac{\\cos\\left(\\frac{A-B}{2}\\right)}{\\sin\\left(\\frac{C}{2}\\right)}", "Mollweide's formula"),
        ("Napier's Analogies", "\\tan\\left(\\frac{A-B}{2}\\right)=\\frac{a-b}{a+b}\\cot\\left(\\frac{C}{2}\\right)", "Napier's analogies"),
        ("Spherical Law of Cosines", "\\cos(a)=\\cos(b)\\cos(c)+\\sin(b)\\sin(c)\\cos(A)", "Spherical triangle"),
        ("Spherical Law of Sines", "\\frac{\\sin(a)}{\\sin(A)}=\\frac{\\sin(b)}{\\sin(B)}=\\frac{\\sin(c)}{\\sin(C)}", "Spherical law of sines"),
        ("Hyperbolic Sine", "\\sinh(x)=\\frac{e^x-e^{-x}}{2}", "Hyperbolic sine"),
        ("Hyperbolic Cosine", "\\cosh(x)=\\frac{e^x+e^{-x}}{2}", "Hyperbolic cosine"),
        ("Hyperbolic Tangent", "\\tanh(x)=\\frac{\\sinh(x)}{\\cosh(x)}", "Hyperbolic tangent"),
        ("Inverse Hyperbolic Sine", "\\sinh^{-1}(x)=\\ln(x+\\sqrt{x^2+1})", "Inverse hyperbolic sine"),
        ("Inverse Hyperbolic Cosine", "\\cosh^{-1}(x)=\\ln(x+\\sqrt{x^2-1})", "Inverse hyperbolic cosine"),
        ("Inverse Hyperbolic Tangent", "\\tanh^{-1}(x)=\\frac{1}{2}\\ln\\left(\\frac{1+x}{1-x}\\right)", "Inverse hyperbolic tangent"),
    ]
    
    for title, latex, desc in additional_trig:
        formulas.append({
            "id": f"trig_{formula_id}",
            "title": title,
            "category": "Trigonometry",
            "latex": latex,
            "description": desc,
            "variables": [],
            "calculator": None
        })
        formula_id += 1
    
    # Additional Calculus formulas (80+)
    additional_calc = [
        ("Derivative - Constant", "\\frac{d}{dx}(c)=0", "Derivative of constant"),
        ("Derivative - Sum Rule", "\\frac{d}{dx}(f+g)=f'+g'", "Derivative of sum"),
        ("Derivative - Difference Rule", "\\frac{d}{dx}(f-g)=f'-g'", "Derivative of difference"),
        ("Derivative - Constant Multiple", "\\frac{d}{dx}(cf)=cf'", "Derivative of constant multiple"),
        ("Derivative of Tangent", "\\frac{d}{dx}(\\tan(x))=\\sec^2(x)", "Derivative of tangent"),
        ("Derivative of Secant", "\\frac{d}{dx}(\\sec(x))=\\sec(x)\\tan(x)", "Derivative of secant"),
        ("Derivative of Cosecant", "\\frac{d}{dx}(\\csc(x))=-\\csc(x)\\cot(x)", "Derivative of cosecant"),
        ("Derivative of Cotangent", "\\frac{d}{dx}(\\cot(x))=-\\csc^2(x)", "Derivative of cotangent"),
        ("Derivative of Arcsin", "\\frac{d}{dx}(\\arcsin(x))=\\frac{1}{\\sqrt{1-x^2}}", "Derivative of arcsin"),
        ("Derivative of Arccos", "\\frac{d}{dx}(\\arccos(x))=-\\frac{1}{\\sqrt{1-x^2}}", "Derivative of arccos"),
        ("Derivative of Arctan", "\\frac{d}{dx}(\\arctan(x))=\\frac{1}{1+x^2}", "Derivative of arctan"),
        ("Derivative of a^x", "\\frac{d}{dx}(a^x)=a^x\\ln(a)", "Derivative of exponential base a"),
        ("Derivative of log_a(x)", "\\frac{d}{dx}(\\log_a(x))=\\frac{1}{x\\ln(a)}", "Derivative of logarithm base a"),
        ("Second Derivative", "f''(x)=\\frac{d^2}{dx^2}f(x)", "Second derivative"),
        ("Higher Order Derivative", "f^{(n)}(x)=\\frac{d^n}{dx^n}f(x)", "nth derivative"),
        ("Implicit Differentiation", "\\frac{dy}{dx}=-\\frac{F_x}{F_y}", "Implicit differentiation"),
        ("Related Rates", "\\frac{dy}{dt}=\\frac{dy}{dx}\\cdot\\frac{dx}{dt}", "Related rates formula"),
        ("Linear Approximation", "f(x)\\approx f(a)+f'(a)(x-a)", "Linear approximation"),
        ("Taylor Series", "f(x)=\\sum_{n=0}^{\\infty}\\frac{f^{(n)}(a)}{n!}(x-a)^n", "Taylor series expansion"),
        ("Maclaurin Series", "f(x)=\\sum_{n=0}^{\\infty}\\frac{f^{(n)}(0)}{n!}x^n", "Maclaurin series"),
        ("Riemann Sum", "\\int_a^b f(x)dx=\\lim_{n\\to\\infty}\\sum_{i=1}^n f(x_i^*)\\Delta x", "Riemann sum"),
        ("Fundamental Theorem Part 1", "\\frac{d}{dx}\\int_a^x f(t)dt=f(x)", "FTC part 1"),
        ("Fundamental Theorem Part 2", "\\int_a^b f(x)dx=F(b)-F(a)", "FTC part 2"),
        ("U-Substitution", "\\int f(g(x))g'(x)dx=\\int f(u)du", "U-substitution method"),
        ("Integration by Parts", "\\int u dv=uv-\\int v du", "Integration by parts"),
        ("Partial Fractions Integration", "\\int\\frac{P(x)}{Q(x)}dx", "Integration using partial fractions"),
        ("Trigonometric Substitution", "x=a\\sin(\\theta), x=a\\tan(\\theta), x=a\\sec(\\theta)", "Trig substitution"),
        ("Improper Integral Type 1", "\\int_a^{\\infty} f(x)dx=\\lim_{b\\to\\infty}\\int_a^b f(x)dx", "Improper integral infinite limit"),
        ("Improper Integral Type 2", "\\int_a^b f(x)dx=\\lim_{t\\to a^+}\\int_t^b f(x)dx", "Improper integral discontinuity"),
        ("Arc Length", "L=\\int_a^b\\sqrt{1+[f'(x)]^2}dx", "Arc length formula"),
        ("Surface Area of Revolution", "SA=2\\pi\\int_a^b f(x)\\sqrt{1+[f'(x)]^2}dx", "Surface area of revolution"),
        ("Volume by Disks", "V=\\pi\\int_a^b [f(x)]^2dx", "Volume by disk method"),
        ("Volume by Washers", "V=\\pi\\int_a^b ([f(x)]^2-[g(x)]^2)dx", "Volume by washer method"),
        ("Volume by Shells", "V=2\\pi\\int_a^b xf(x)dx", "Volume by shell method"),
        ("Average Value", "f_{avg}=\\frac{1}{b-a}\\int_a^b f(x)dx", "Average value of function"),
        ("Mean Value Theorem for Integrals", "f(c)=\\frac{1}{b-a}\\int_a^b f(x)dx", "MVT for integrals"),
        ("Trapezoidal Rule", "\\int_a^b f(x)dx\\approx\\frac{\\Delta x}{2}[f(x_0)+2f(x_1)+...+2f(x_{n-1})+f(x_n)]", "Trapezoidal approximation"),
        ("Simpson's Rule", "\\int_a^b f(x)dx\\approx\\frac{\\Delta x}{3}[f(x_0)+4f(x_1)+2f(x_2)+...+4f(x_{n-1})+f(x_n)]", "Simpson's rule"),
        ("Limit Definition", "\\lim_{x\\to a}f(x)=L", "Limit definition"),
        ("Continuity", "\\lim_{x\\to a}f(x)=f(a)", "Continuity definition"),
        ("Squeeze Theorem", "If g(x)\\leq f(x)\\leq h(x) and \\lim g=\\lim h=L, then \\lim f=L", "Squeeze theorem"),
        ("Intermediate Value Theorem", "If f continuous on [a,b] and k between f(a) and f(b), then f(c)=k", "IVT"),
        ("Extreme Value Theorem", "Continuous function on [a,b] attains max and min", "EVT"),
        ("Rolle's Theorem", "If f(a)=f(b) and f differentiable, then f'(c)=0", "Rolle's theorem"),
        ("Mean Value Theorem", "f'(c)=\\frac{f(b)-f(a)}{b-a}", "Mean value theorem"),
        ("Critical Point", "f'(c)=0 or f'(c) undefined", "Critical point definition"),
        ("First Derivative Test", "Sign change of f' indicates local extrema", "First derivative test"),
        ("Second Derivative Test", "f''(c)>0 implies local min, f''(c)<0 implies local max", "Second derivative test"),
        ("Concavity", "f''(x)>0 implies concave up, f''(x)<0 implies concave down", "Concavity test"),
        ("Inflection Point", "Point where concavity changes", "Inflection point"),
        ("Optimization", "Find max/min of function subject to constraints", "Optimization problem"),
        ("Newton's Method", "x_{n+1}=x_n-\\frac{f(x_n)}{f'(x_n)}", "Newton's method for roots"),
        ("Differential", "dy=f'(x)dx", "Differential definition"),
        ("Error Approximation", "\\Delta y\\approx f'(x)\\Delta x", "Error approximation using differentials"),
    ]
    
    for title, latex, desc in additional_calc:
        formulas.append({
            "id": f"calc_{formula_id}",
            "title": title,
            "category": "Calculus",
            "latex": latex,
            "description": desc,
            "variables": [],
            "calculator": None
        })
        formula_id += 1
    
    # Additional Mechanics formulas (50+)
    additional_mechanics = [
        ("Uniform Motion", "s=ut+\\frac{1}{2}at^2", "Displacement with constant acceleration"),
        ("Velocity-Time Relation", "v=u+at", "Final velocity formula"),
        ("Velocity-Displacement", "v^2=u^2+2as", "Velocity squared formula"),
        ("Average Velocity", "v_{avg}=\\frac{u+v}{2}", "Average velocity"),
        ("Free Fall", "h=\\frac{1}{2}gt^2", "Height in free fall"),
        ("Projectile Motion - Range", "R=\\frac{v^2\\sin(2\\theta)}{g}", "Range of projectile"),
        ("Projectile Motion - Max Height", "H=\\frac{v^2\\sin^2(\\theta)}{2g}", "Maximum height of projectile"),
        ("Projectile Motion - Time of Flight", "T=\\frac{2v\\sin(\\theta)}{g}", "Time of flight"),
        ("Circular Motion - Period", "T=\\frac{2\\pi r}{v}", "Period of circular motion"),
        ("Circular Motion - Frequency", "f=\\frac{1}{T}", "Frequency of circular motion"),
        ("Banking Angle", "\\tan(\\theta)=\\frac{v^2}{rg}", "Banking angle for curves"),
        ("Friction Force", "f=\\mu N", "Friction force"),
        ("Static Friction", "f_s\\leq\\mu_s N", "Static friction"),
        ("Kinetic Friction", "f_k=\\mu_k N", "Kinetic friction"),
        ("Coefficient of Restitution", "e=\\frac{v_2-v_1}{u_1-u_2}", "Coefficient of restitution"),
        ("Elastic Collision", "m_1u_1+m_2u_2=m_1v_1+m_2v_2", "Momentum conservation"),
        ("Inelastic Collision", "m_1u_1+m_2u_2=(m_1+m_2)v", "Perfectly inelastic collision"),
        ("Rocket Equation", "\\Delta v=v_e\\ln\\left(\\frac{m_0}{m_f}\\right)", "Tsiolkovsky rocket equation"),
        ("Kepler's First Law", "Planets move in elliptical orbits", "Kepler's first law"),
        ("Kepler's Second Law", "\\frac{dA}{dt}=\\frac{L}{2m}", "Equal areas in equal times"),
        ("Kepler's Third Law", "T^2\\propto a^3", "Period squared proportional to semi-major axis cubed"),
        ("Orbital Velocity", "v=\\sqrt{\\frac{GM}{r}}", "Orbital velocity"),
        ("Escape Velocity (General)", "v_e=\\sqrt{\\frac{2GM}{r}}", "Escape velocity formula"),
        ("Gravitational Potential Energy (General)", "U=-\\frac{GMm}{r}", "Gravitational potential energy"),
        ("Gravitational Field", "g=\\frac{GM}{r^2}", "Gravitational field strength"),
        ("Tidal Force", "F_{tidal}\\approx\\frac{2GMmr}{R^3}", "Tidal force approximation"),
        ("Rigid Body Rotation", "\\tau=I\\alpha", "Torque and angular acceleration"),
        ("Parallel Axis Theorem", "I=I_{cm}+md^2", "Moment of inertia parallel axis"),
        ("Perpendicular Axis Theorem", "I_z=I_x+I_y", "Perpendicular axis theorem"),
        ("Rolling Without Slipping", "v=r\\omega", "Condition for rolling"),
        ("Rolling Kinetic Energy", "KE=\\frac{1}{2}mv^2+\\frac{1}{2}I\\omega^2", "Total kinetic energy of rolling"),
        ("Precession", "\\Omega=\\frac{mgr}{I\\omega}", "Precession angular velocity"),
        ("Elastic Potential Energy", "U=\\frac{1}{2}kx^2", "Spring potential energy"),
        ("Damped Harmonic Motion", "x=Ae^{-\\gamma t}\\cos(\\omega t+\\phi)", "Damped oscillation"),
        ("Natural Frequency", "\\omega_0=\\sqrt{\\frac{k}{m}}", "Natural frequency of oscillator"),
        ("Damping Coefficient", "\\gamma=\\frac{b}{2m}", "Damping coefficient"),
        ("Quality Factor", "Q=\\frac{\\omega_0}{\\gamma}", "Quality factor of oscillator"),
        ("Resonance Frequency", "\\omega_r=\\sqrt{\\omega_0^2-\\gamma^2}", "Resonance frequency"),
        ("Forced Oscillation", "x=\\frac{F_0/m}{\\sqrt{(\\omega_0^2-\\omega^2)^2+(\\gamma\\omega)^2}}\\cos(\\omega t-\\delta)", "Forced oscillation"),
        ("Wave on String", "v=\\sqrt{\\frac{T}{\\mu}}", "Wave speed on string"),
        ("Standing Wave", "f_n=\\frac{nv}{2L}", "Frequency of standing wave"),
        ("Beat Frequency", "f_{beat}=|f_1-f_2|", "Beat frequency"),
        ("Doppler Effect (Sound)", "f'=f\\frac{v\\pm v_o}{v\\mp v_s}", "Doppler effect for sound"),
        ("Mach Number", "M=\\frac{v}{v_s}", "Mach number"),
        ("Shock Wave Angle", "\\sin(\\theta)=\\frac{v_s}{v}", "Shock wave angle"),
        ("Bernoulli's Principle", "P+\\frac{1}{2}\\rho v^2+\\rho gh=constant", "Bernoulli's equation"),
        ("Continuity Equation", "A_1v_1=A_2v_2", "Continuity equation for fluids"),
        ("Poiseuille's Law", "Q=\\frac{\\pi r^4\\Delta P}{8\\eta L}", "Flow rate in pipe"),
        ("Stokes' Law", "F=6\\pi\\eta rv", "Drag force on sphere"),
        ("Reynolds Number", "Re=\\frac{\\rho vL}{\\eta}", "Reynolds number"),
    ]
    
    for title, latex, desc in additional_mechanics:
        formulas.append({
            "id": f"mech_{formula_id}",
            "title": title,
            "category": "Mechanics",
            "latex": latex,
            "description": desc,
            "variables": [],
            "calculator": None
        })
        formula_id += 1
    
    # Additional Electricity formulas (40+)
    additional_electricity = [
        ("Series Capacitance", "\\frac{1}{C_{total}}=\\frac{1}{C_1}+\\frac{1}{C_2}+...", "Total capacitance in series"),
        ("Parallel Capacitance", "C_{total}=C_1+C_2+...", "Total capacitance in parallel"),
        ("Energy Density", "u=\\frac{1}{2}\\epsilon_0E^2", "Energy density in electric field"),
        ("Gauss's Law", "\\oint\\vec{E}\\cdot d\\vec{A}=\\frac{Q_{enc}}{\\epsilon_0}", "Gauss's law"),
        ("Electric Flux", "\\Phi_E=\\vec{E}\\cdot\\vec{A}", "Electric flux"),
        ("Electric Field - Infinite Plane", "E=\\frac{\\sigma}{2\\epsilon_0}", "Electric field of infinite plane"),
        ("Electric Field - Line Charge", "E=\\frac{\\lambda}{2\\pi\\epsilon_0r}", "Electric field of line charge"),
        ("Electric Field - Ring", "E=\\frac{kQx}{(x^2+R^2)^{3/2}}", "Electric field on axis of ring"),
        ("Electric Field - Disk", "E=\\frac{\\sigma}{2\\epsilon_0}\\left(1-\\frac{x}{\\sqrt{x^2+R^2}}\\right)", "Electric field of disk"),
        ("Electric Potential Energy", "U=\\frac{kq_1q_2}{r}", "Potential energy of two charges"),
        ("Capacitor Energy", "U=\\frac{Q^2}{2C}", "Energy stored in capacitor"),
        ("RC Circuit - Charging", "Q=Q_0(1-e^{-t/RC})", "Capacitor charging"),
        ("RC Circuit - Discharging", "Q=Q_0e^{-t/RC}", "Capacitor discharging"),
        ("Time Constant", "\\tau=RC", "RC time constant"),
        ("RL Circuit", "I=I_0(1-e^{-tR/L})", "RL circuit current"),
        ("Inductance Time Constant", "\\tau=\\frac{L}{R}", "RL time constant"),
        ("Magnetic Field - Solenoid", "B=\\mu_0nI", "Magnetic field inside solenoid"),
        ("Magnetic Field - Loop", "B=\\frac{\\mu_0I}{2R}", "Magnetic field at center of loop"),
        ("Biot-Savart Law", "d\\vec{B}=\\frac{\\mu_0}{4\\pi}\\frac{Id\\vec{l}\\times\\hat{r}}{r^2}", "Biot-Savart law"),
        ("Ampère's Law", "\\oint\\vec{B}\\cdot d\\vec{l}=\\mu_0I_{enc}", "Ampère's law"),
        ("Magnetic Flux", "\\Phi_B=\\vec{B}\\cdot\\vec{A}", "Magnetic flux"),
        ("Self-Inductance", "L=\\frac{\\Phi_B}{I}", "Self-inductance definition"),
        ("Mutual Inductance", "M=\\frac{\\Phi_{21}}{I_1}", "Mutual inductance"),
        ("Induced EMF", "\\varepsilon=-L\\frac{dI}{dt}", "Self-induced EMF"),
        ("LC Oscillation", "\\omega=\\frac{1}{\\sqrt{LC}}", "LC circuit frequency"),
        ("RLC Circuit", "Q=Q_0e^{-Rt/2L}\\cos(\\omega t+\\phi)", "RLC oscillation"),
        ("AC Voltage", "V=V_0\\sin(\\omega t)", "AC voltage"),
        ("AC Current", "I=I_0\\sin(\\omega t+\\phi)", "AC current"),
        ("RMS Voltage", "V_{rms}=\\frac{V_0}{\\sqrt{2}}", "Root mean square voltage"),
        ("RMS Current", "I_{rms}=\\frac{I_0}{\\sqrt{2}}", "Root mean square current"),
        ("AC Power", "P=I_{rms}V_{rms}\\cos(\\phi)", "AC power"),
        ("Impedance", "Z=\\sqrt{R^2+(X_L-X_C)^2}", "Impedance"),
        ("Inductive Reactance", "X_L=\\omega L", "Inductive reactance"),
        ("Capacitive Reactance", "X_C=\\frac{1}{\\omega C}", "Capacitive reactance"),
        ("Resonance Frequency", "\\omega_0=\\frac{1}{\\sqrt{LC}}", "Resonance frequency"),
        ("Power Factor", "\\cos(\\phi)=\\frac{R}{Z}", "Power factor"),
        ("Maxwell's Equations - Gauss", "\\nabla\\cdot\\vec{E}=\\frac{\\rho}{\\epsilon_0}", "Gauss's law differential"),
        ("Maxwell's Equations - Gauss Magnetic", "\\nabla\\cdot\\vec{B}=0", "No magnetic monopoles"),
        ("Maxwell's Equations - Faraday", "\\nabla\\times\\vec{E}=-\\frac{\\partial\\vec{B}}{\\partial t}", "Faraday's law"),
        ("Maxwell's Equations - Ampère", "\\nabla\\times\\vec{B}=\\mu_0\\vec{J}+\\mu_0\\epsilon_0\\frac{\\partial\\vec{E}}{\\partial t}", "Ampère-Maxwell law"),
        ("Poynting Vector", "\\vec{S}=\\frac{1}{\\mu_0}\\vec{E}\\times\\vec{B}", "Energy flux"),
    ]
    
    for title, latex, desc in additional_electricity:
        formulas.append({
            "id": f"elec_{formula_id}",
            "title": title,
            "category": "Electricity",
            "latex": latex,
            "description": desc,
            "variables": [],
            "calculator": None
        })
        formula_id += 1
    
    # Additional Waves formulas (30+)
    additional_waves = [
        ("Standing Wave - String", "\\lambda_n=\\frac{2L}{n}", "Wavelength of standing wave"),
        ("Beat Frequency", "f_{beat}=|f_1-f_2|", "Beat frequency"),
        ("Intensity", "I=\\frac{P}{A}", "Wave intensity"),
        ("Intensity Level", "\\beta=10\\log\\left(\\frac{I}{I_0}\\right)", "Sound intensity level in dB"),
        ("Doppler Effect - Light", "f'=f\\sqrt{\\frac{1+v/c}{1-v/c}}", "Relativistic Doppler effect"),
        ("Bragg's Law", "n\\lambda=2d\\sin(\\theta)", "X-ray diffraction"),
        ("Diffraction Grating", "d\\sin(\\theta)=m\\lambda", "Diffraction grating equation"),
        ("Resolving Power", "R=\\frac{\\lambda}{\\Delta\\lambda}", "Resolving power"),
        ("Rayleigh Criterion", "\\theta=1.22\\frac{\\lambda}{D}", "Angular resolution"),
        ("Thin Film Interference", "2nt=m\\lambda", "Constructive interference"),
        ("Brewster's Angle", "\\tan(\\theta_B)=\\frac{n_2}{n_1}", "Brewster's angle"),
        ("Malus's Law", "I=I_0\\cos^2(\\theta)", "Polarized light intensity"),
        ("Refractive Index", "n=\\frac{c}{v}", "Refractive index"),
        ("Critical Angle", "\\sin(\\theta_c)=\\frac{n_2}{n_1}", "Total internal reflection"),
        ("Lensmaker's Equation", "\\frac{1}{f}=(n-1)\\left(\\frac{1}{R_1}-\\frac{1}{R_2}\\right)", "Lensmaker's equation"),
        ("Angular Magnification", "M=\\frac{\\theta'}{\\theta}", "Angular magnification"),
        ("Numerical Aperture", "NA=n\\sin(\\theta)", "Numerical aperture"),
        ("Fresnel Equations", "r=\\frac{n_1-n_2}{n_1+n_2}", "Reflection coefficient"),
        ("Group Velocity", "v_g=\\frac{d\\omega}{dk}", "Group velocity"),
        ("Phase Velocity", "v_p=\\frac{\\omega}{k}", "Phase velocity"),
        ("Dispersion Relation", "\\omega(k)", "Dispersion relation"),
        ("Wave Packet", "\\Delta x\\Delta k\\geq\\frac{1}{2}", "Wave packet uncertainty"),
        ("Coherence Length", "l_c=\\frac{c}{\\Delta\\nu}", "Coherence length"),
        ("Coherence Time", "\\tau_c=\\frac{1}{\\Delta\\nu}", "Coherence time"),
        ("Huygens' Principle", "Every point on wavefront is source of spherical waves", "Huygens' principle"),
        ("Fermat's Principle", "Light takes path of least time", "Fermat's principle"),
        ("Optical Path Length", "OPL=\\int n(s)ds", "Optical path length"),
        ("Abbe Number", "V=\\frac{n_D-1}{n_F-n_C}", "Abbe number for dispersion"),
        ("Chromatic Aberration", "\\Delta f=\\frac{f}{V}", "Chromatic aberration"),
        ("Spherical Aberration", "SA=\\frac{h^4}{8f^3}", "Spherical aberration"),
    ]
    
    for title, latex, desc in additional_waves:
        formulas.append({
            "id": f"wave_{formula_id}",
            "title": title,
            "category": "Waves",
            "latex": latex,
            "description": desc,
            "variables": [],
            "calculator": None
        })
        formula_id += 1
    
    # Additional Thermodynamics formulas (40+)
    additional_thermo = [
        ("Boyle's Law", "P_1V_1=P_2V_2", "Pressure-volume relationship"),
        ("Charles's Law", "\\frac{V_1}{T_1}=\\frac{V_2}{T_2}", "Volume-temperature relationship"),
        ("Gay-Lussac's Law", "\\frac{P_1}{T_1}=\\frac{P_2}{T_2}", "Pressure-temperature relationship"),
        ("Combined Gas Law", "\\frac{P_1V_1}{T_1}=\\frac{P_2V_2}{T_2}", "Combined gas law"),
        ("Avogadro's Law", "\\frac{V_1}{n_1}=\\frac{V_2}{n_2}", "Volume-mole relationship"),
        ("Van der Waals Equation", "\\left(P+\\frac{an^2}{V^2}\\right)(V-nb)=nRT", "Van der Waals equation"),
        ("Maxwell-Boltzmann Distribution", "f(v)=4\\pi n\\left(\\frac{m}{2\\pi kT}\\right)^{3/2}v^2e^{-mv^2/2kT}", "Speed distribution"),
        ("Most Probable Speed", "v_{mp}=\\sqrt{\\frac{2kT}{m}}", "Most probable speed"),
        ("Average Speed", "\\bar{v}=\\sqrt{\\frac{8kT}{\\pi m}}", "Average speed"),
        ("RMS Speed", "v_{rms}=\\sqrt{\\frac{3kT}{m}}", "Root mean square speed"),
        ("Mean Free Path", "\\lambda=\\frac{1}{\\sqrt{2}\\pi d^2n}", "Mean free path"),
        ("Collision Frequency", "Z=\\sqrt{2}\\pi d^2\\bar{v}n", "Collision frequency"),
        ("Heat Capacity", "C=\\frac{Q}{\\Delta T}", "Heat capacity"),
        ("Specific Heat Capacity", "c=\\frac{Q}{m\\Delta T}", "Specific heat capacity"),
        ("Molar Heat Capacity", "C_m=\\frac{Q}{n\\Delta T}", "Molar heat capacity"),
        ("Latent Heat of Fusion", "Q=mL_f", "Latent heat of fusion"),
        ("Latent Heat of Vaporization", "Q=mL_v", "Latent heat of vaporization"),
        ("Heat of Combustion", "\\Delta H_{comb}", "Heat of combustion"),
        ("Enthalpy", "H=U+PV", "Enthalpy definition"),
        ("Enthalpy Change", "\\Delta H=\\Delta U+P\\Delta V", "Enthalpy change"),
        ("Hess's Law", "\\Delta H_{total}=\\sum\\Delta H_i", "Hess's law"),
        ("Bond Energy", "\\Delta H=\\sum BE_{reactants}-\\sum BE_{products}", "Bond energy calculation"),
        ("Entropy", "\\Delta S=\\int\\frac{dQ_{rev}}{T}", "Entropy definition"),
        ("Entropy Change - Isothermal", "\\Delta S=\\frac{Q}{T}", "Entropy change isothermal"),
        ("Entropy Change - Adiabatic", "\\Delta S=0", "Entropy change adiabatic"),
        ("Entropy Change - Ideal Gas", "\\Delta S=nR\\ln\\left(\\frac{V_2}{V_1}\\right)", "Entropy change ideal gas"),
        ("Gibbs Free Energy", "G=H-TS", "Gibbs free energy"),
        ("Gibbs Free Energy Change", "\\Delta G=\\Delta H-T\\Delta S", "Gibbs free energy change"),
        ("Spontaneity", "\\Delta G<0 implies spontaneous", "Spontaneity criterion"),
        ("Clausius-Clapeyron Equation", "\\ln\\left(\\frac{P_2}{P_1}\\right)=\\frac{\\Delta H_{vap}}{R}\\left(\\frac{1}{T_1}-\\frac{1}{T_2}\\right)", "Vapor pressure"),
        ("Heat Engine Efficiency", "\\eta=\\frac{W}{Q_h}=1-\\frac{Q_c}{Q_h}", "Heat engine efficiency"),
        ("Carnot Efficiency", "\\eta=1-\\frac{T_c}{T_h}", "Carnot efficiency"),
        ("Coefficient of Performance", "COP=\\frac{Q_c}{W}", "Refrigerator COP"),
        ("Heat Pump COP", "COP_{HP}=\\frac{Q_h}{W}", "Heat pump coefficient"),
        ("Otto Cycle Efficiency", "\\eta=1-\\frac{1}{r^{\\gamma-1}}", "Otto cycle efficiency"),
        ("Diesel Cycle Efficiency", "\\eta=1-\\frac{1}{r^{\\gamma-1}}\\frac{\\rho^{\\gamma}-1}{\\gamma(\\rho-1)}", "Diesel cycle"),
        ("Brayton Cycle", "\\eta=1-\\frac{1}{r_p^{(\\gamma-1)/\\gamma}}", "Brayton cycle efficiency"),
        ("Stefan-Boltzmann Law", "P=\\sigma AT^4", "Radiated power"),
        ("Wien's Displacement Law", "\\lambda_{max}T=b", "Wien's law"),
        ("Planck's Law", "B(\\lambda,T)=\\frac{2hc^2}{\\lambda^5}\\frac{1}{e^{hc/\\lambda kT}-1}", "Blackbody radiation"),
    ]
    
    for title, latex, desc in additional_thermo:
        formulas.append({
            "id": f"thermo_{formula_id}",
            "title": title,
            "category": "Thermodynamics",
            "latex": latex,
            "description": desc,
            "variables": [],
            "calculator": None
        })
        formula_id += 1
    
    # Additional Chemistry formulas (30+)
    additional_chemistry = [
        ("Mole Fraction", "X_i=\\frac{n_i}{n_{total}}", "Mole fraction"),
        ("Mass Percent", "\\%=\\frac{mass_{solute}}{mass_{solution}}\\times100", "Mass percent"),
        ("Volume Percent", "\\%=\\frac{volume_{solute}}{volume_{solution}}\\times100", "Volume percent"),
        ("Parts Per Million", "ppm=\\frac{mass_{solute}}{mass_{solution}}\\times10^6", "Parts per million"),
        ("Molality", "m=\\frac{moles_{solute}}{kg_{solvent}}", "Molality"),
        ("Normality", "N=\\frac{equivalents}{L}", "Normality"),
        ("Raoult's Law", "P_i=X_iP_i^0", "Raoult's law"),
        ("Henry's Law", "C=kP", "Henry's law"),
        ("Colligative Properties - Boiling Point", "\\Delta T_b=K_bm", "Boiling point elevation"),
        ("Colligative Properties - Freezing Point", "\\Delta T_f=K_fm", "Freezing point depression"),
        ("Osmotic Pressure", "\\Pi=MRT", "Osmotic pressure"),
        ("Van't Hoff Factor", "i=\\frac{actual\\ particles}{formula\\ units}", "Van't Hoff factor"),
        ("Rate Constant", "k=Ae^{-E_a/RT}", "Arrhenius equation"),
        ("Half-Life - First Order", "t_{1/2}=\\frac{\\ln(2)}{k}", "First order half-life"),
        ("Half-Life - Second Order", "t_{1/2}=\\frac{1}{k[A]_0}", "Second order half-life"),
        ("Integrated Rate Law - First Order", "\\ln[A]=-kt+\\ln[A]_0", "First order integrated"),
        ("Integrated Rate Law - Second Order", "\\frac{1}{[A]}=kt+\\frac{1}{[A]_0}", "Second order integrated"),
        ("Equilibrium Constant", "K=\\frac{[C]^c[D]^d}{[A]^a[B]^b}", "Equilibrium constant"),
        ("Reaction Quotient", "Q=\\frac{[C]^c[D]^d}{[A]^a[B]^b}", "Reaction quotient"),
        ("Le Chatelier's Principle", "System shifts to counteract change", "Le Chatelier's principle"),
        ("Acid Dissociation Constant", "K_a=\\frac{[H^+][A^-]}{[HA]}", "Acid dissociation constant"),
        ("Base Dissociation Constant", "K_b=\\frac{[OH^-][BH^+]}{[B]}", "Base dissociation constant"),
        ("Water Ion Product", "K_w=[H^+][OH^-]=10^{-14}", "Water ion product"),
        ("pKa", "pK_a=-\\log(K_a)", "pKa definition"),
        ("Buffer Capacity", "\\beta=\\frac{dC_b}{dpH}", "Buffer capacity"),
        ("Titration - Equivalence Point", "M_aV_a=M_bV_b", "Equivalence point"),
        ("Redox - Nernst Equation", "E=E^0-\\frac{RT}{nF}\\ln(Q)", "Nernst equation"),
        ("Standard Cell Potential", "E^0_{cell}=E^0_{cathode}-E^0_{anode}", "Standard cell potential"),
        ("Faraday's Constant", "F=96485\\ C/mol", "Faraday's constant"),
        ("Electrolysis", "m=\\frac{MIt}{nF}", "Mass deposited in electrolysis"),
    ]
    
    for title, latex, desc in additional_chemistry:
        formulas.append({
            "id": f"chem_{formula_id}",
            "title": title,
            "category": "Chemistry",
            "latex": latex,
            "description": desc,
            "variables": [],
            "calculator": None
        })
        formula_id += 1
    
    # Additional Statistics formulas (20+)
    additional_stats = [
        ("Sample Mean", "\\bar{x}=\\frac{1}{n}\\sum_{i=1}^{n}x_i", "Sample mean"),
        ("Sample Variance", "s^2=\\frac{1}{n-1}\\sum_{i=1}^{n}(x_i-\\bar{x})^2", "Sample variance"),
        ("Sample Standard Deviation", "s=\\sqrt{\\frac{1}{n-1}\\sum_{i=1}^{n}(x_i-\\bar{x})^2}", "Sample standard deviation"),
        ("Standard Error", "SE=\\frac{\\sigma}{\\sqrt{n}}", "Standard error of mean"),
        ("Confidence Interval", "\\bar{x}\\pm z\\frac{\\sigma}{\\sqrt{n}}", "Confidence interval"),
        ("T-Statistic", "t=\\frac{\\bar{x}-\\mu}{s/\\sqrt{n}}", "T-statistic"),
        ("Chi-Square Statistic", "\\chi^2=\\sum\\frac{(O-E)^2}{E}", "Chi-square statistic"),
        ("F-Statistic", "F=\\frac{s_1^2}{s_2^2}", "F-statistic"),
        ("Regression Line", "y=a+bx", "Linear regression"),
        ("Slope of Regression", "b=\\frac{\\sum(x_i-\\bar{x})(y_i-\\bar{y})}{\\sum(x_i-\\bar{x})^2}", "Regression slope"),
        ("Y-Intercept", "a=\\bar{y}-b\\bar{x}", "Y-intercept"),
        ("Coefficient of Determination", "R^2=1-\\frac{SS_{res}}{SS_{tot}}", "R-squared"),
        ("Poisson Distribution", "P(X=k)=\\frac{\\lambda^ke^{-\\lambda}}{k!}", "Poisson distribution"),
        ("Exponential Distribution", "f(x)=\\lambda e^{-\\lambda x}", "Exponential distribution"),
        ("Gamma Distribution", "f(x)=\\frac{\\lambda^r x^{r-1}e^{-\\lambda x}}{\\Gamma(r)}", "Gamma distribution"),
        ("Beta Distribution", "f(x)=\\frac{x^{\\alpha-1}(1-x)^{\\beta-1}}{B(\\alpha,\\beta)}", "Beta distribution"),
        ("Central Limit Theorem", "\\bar{X}\\sim N(\\mu,\\frac{\\sigma^2}{n})", "Central limit theorem"),
        ("Law of Large Numbers", "\\lim_{n\\to\\infty}\\bar{X}_n=\\mu", "Law of large numbers"),
        ("Bayes' Theorem", "P(A|B)=\\frac{P(B|A)P(A)}{P(B)}", "Bayes' theorem"),
        ("Conditional Probability", "P(A|B)=\\frac{P(A\\cap B)}{P(B)}", "Conditional probability"),
        ("Independent Events", "P(A\\cap B)=P(A)P(B)", "Independent events"),
        ("Mutually Exclusive", "P(A\\cup B)=P(A)+P(B)", "Mutually exclusive events"),
    ]
    
    for title, latex, desc in additional_stats:
        formulas.append({
            "id": f"stat_{formula_id}",
            "title": title,
            "category": "Statistics",
            "latex": latex,
            "description": desc,
            "variables": [],
            "calculator": None
        })
        formula_id += 1
    
    return {"formulas": formulas}

if __name__ == "__main__":
    output = generate_formulas()
    
    # Ensure assets directory exists
    os.makedirs("assets", exist_ok=True)
    
    # Write to JSON file
    with open("assets/formulas.json", "w", encoding="utf-8") as f:
        json.dump(output, f, indent=2, ensure_ascii=False)
    
    print(f"Generated {len(output['formulas'])} formulas")
    print("Formulas saved to assets/formulas.json")

